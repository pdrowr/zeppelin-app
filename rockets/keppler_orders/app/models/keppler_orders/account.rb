module KepplerOrders
  class Account < ApplicationRecord
    after_create :create_first_order
    belongs_to :client, class_name: 'KepplerClients::Client'
    belongs_to :waiter, class_name: 'KepplerStaff::Waiter'
    belongs_to :table,  class_name: 'KepplerEnvironments::Table', optional: true
    belongs_to :period, class_name: 'KepplerPeriods::Period'
    has_many   :orders

    scope :today_orders, -> { orders.where(period_id: current_period_id) }

    def total
      orders.map(&:total).compact.sum
    end

    def have_active_orders
      orders.where(status: 'ACTIVE').blank?
    end

    def cancel
      orders.map(&:cancel)
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

  end
end
