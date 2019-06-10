# frozen_string_literal: true

module KepplerOrders
  # Order Model
  class Order < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    acts_as_list
    acts_as_paranoid

    belongs_to :client, class_name: 'KepplerClients::Client'
    belongs_to :waiter, class_name: 'KepplerStaff::Waiter'
    belongs_to :table, class_name: 'KepplerEnvironments::Table'
    belongs_to :period, class_name: 'KepplerPeriods::Period'

    has_many :dishes, -> { order(id: :asc) }, class_name: 'KepplerOrders::Item'
    scope :today_orders, -> { where(period_id: current_period_id) }

    def self.index_attributes
      %i[client_id waiter_id table_id status]
    end

    def total
      price = dishes.map { |dish| dish.price.to_i * dish.quantity.to_i }
      price.reduce(:+)
    end

    def send_to_kitchen
      update(status: 'IN_KITCHEN')
    end

    def self.current_orders
      today_orders.where("status = 'ACTIVE' or status = 'IN_KITCHEN'")
                  .order(id: :asc)
    end

    def self.orders_in_kitchen
      today_orders.where(status: 'IN_KITCHEN').order(id: :asc)
    end

    def self.completed_orders
      orders_in_kitchen.select do |order|
        order.dishes.where(completed: true).count.eql?(order.dishes.count)
      end.reverse
    end

    def self.incompleted_orders
      orders_in_kitchen.where(status: 'IN_KITCHEN').select do |order|
        !order.dishes.where(completed: true).count.eql?(order.dishes.count)
      end
    end

    def percentage
      completed = dishes.where(completed: true).count
      return 0 if completed.zero?
      ((completed * 100) / dishes.count)
    end

    def in_kitchen?
      status.eql?('IN_KITCHEN')
    end

    def self.current_period_id
      KepplerPeriods::Period&.current_period&.id
    end

    def created_time
      created_at.time.strftime("%I:%M %p")
    end

    def completed_time
      return unless dishes.where(completed: true).count.eql?(dishes.count)
      dishes.pluck(:completed_at).compact.max.strftime("%I:%M %p")
    end

    def cancel
      toggle!(:cancelled)
      dishes.update_all(cancelled: true)
    end

    def get_minutes
      seconds = (Time.now - created_at).to_i
      minuts = (seconds / 60)
    end

    def foods
      dishes.select { |dish| !dish.dish.is_drink? }
    end

    def drinks
      dishes.select { |dish| dish.dish.is_drink? }
    end

    def have_drinks?
      !drinks.blank?
    end

    def order_status
      if (get_minutes < 15)
        return 'normal'
      elsif (get_minutes >= 15 && get_minutes <= 24)
        return 'alert'
      elsif (get_minutes >= 25)
        return 'danger'
      end
    end
  end
end
