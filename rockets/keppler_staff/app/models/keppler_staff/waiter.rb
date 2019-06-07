# frozen_string_literal: true

module KepplerStaff
  # Member Model
  class Waiter < KepplerStaff::Member
    has_many :orders, class_name: 'KepplerOrders::Order'

    def current_orders
      orders.current_orders
    end

    private

    def today
      Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    end


  end
end
