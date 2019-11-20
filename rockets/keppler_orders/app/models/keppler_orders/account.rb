module KepplerOrders
  class Account < ApplicationRecord
    after_create :create_reference, :create_first_order
    belongs_to :client, class_name: 'KepplerClients::Client'
    belongs_to :waiter, class_name: 'KepplerStaff::Waiter'
    belongs_to :table,  class_name: 'KepplerEnvironments::Table', optional: true
    belongs_to :period, class_name: 'KepplerPeriods::Period'
    has_many   :orders

    scope :today_orders, -> { orders.where(period_id: current_period_id) }

    def subtotal
      orders.map { |o| o if !o.completed || !o.cancelled }.compact.map(&:total).compact.sum
    end

    def iva
      return 0 if subtotal.nil?
      subtotal * 0.12
    end


    def total
      subtotal + iva
    end

    def doc
      "E#{table.id_consumo.strip}00#{id}"
    end

    def create_reference
      code = SecureRandom.hex(4)
      while Account.where(reference: code).any? do
        code = SecureRandom.hex(4)
      end

      update(reference: code)
    end

    def have_active_orders
      orders.where(status: 'ACTIVE').blank?
    end

    def have_incompleted_orders?
      !orders.where(cancelled: false).map { |o| o if !o.completed }.compact.blank?
    end

    def cancel
      orders.map(&:cancel)
      toggle!(:cancelled)
      update(cancelled_at: DateTime.now, status: 'CANCELLED')
    end

    def dishes_count
      orders.map(&:dishes).flatten.size
    end

    def close
      KepplerOrders::PremiumOrder.transaction do
        begin
          order = PremiumOrder.new_order(self)
          order.save!
          orders.where(cancelled: false).each do |order|
            order.dishes.where(cancelled: false).each do |order_article|
              order_article.quantity.times do
                item = KepplerOrders::PremiumItem.new_order_item(order_article)
                item.save!
              end
            end
          end
          update(status: 'COMPLETED')
          return :success
        rescue StandardError => e
          puts e
          return :fail
        end
      end
    end

    def premium_order
      KepplerOrders::PremiumOrder.where(documento: doc).first
    end

    def fac_premium_order
      KepplerOrders::PremiumOrder.where(ordentrab: doc).first
    end

    def fac_status
      order = self.premium_order
      fac   = self.fac_premium_order

      if self.cancelled?
        'Cancelada'
      else
        if status.eql?('ACTIVE')
          'Activa'
        elsif fac.nil? && order.nil?
          'Anulada'
        elsif fac&.ordentrab&.strip&.eql?(self.doc.strip) && fac&.tipodoc&.eql?('FAC')
          'Facturada'
        else
          'Activa'
        end
      end
    end

    private

    def create_first_order
      orders.create(
        status: 'ACTIVE',
        period_id: self.period_id
      )
    end

    def current_period_id
      KepplerPeriods::Period&.current_period&.id
    end

    def completed?
      dishes_count = orders.map(&:dishes).flatten.size
    end

  end
end
