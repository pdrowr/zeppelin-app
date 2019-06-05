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
    has_many :dishes, class_name: 'KepplerOrders::Item'

    scope :today_orders, -> { where(created_at: today) }

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

    def self.today
      Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    end

    def self.completed_orders
      orders_in_kitchen.select do |order|
        order.dishes.where(completed: true).count.eql?(order.dishes.count)
      end
    end

    def self.incompleted_orders
      orders_in_kitchen.where(status: 'IN_KITCHEN').select do |order|
        !order.dishes.where(completed: true).count.eql?(order.dishes.count)
      end
    end

    def percentage
      all = dishes.count
      completed = dishes.where(completed: true).count

      return 0 if completed.zero?

      ((completed * 100) / all)
    end

    def in_kitchen?
      status.eql?('IN_KITCHEN')
    end

  end
end
