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

    belongs_to :account
    has_many   :dishes,       -> { order(id: :asc) }, class_name: 'KepplerOrders::Item'
    scope      :today_orders, -> { where(period_id: current_period_id) }

    def self.index_attributes
      %i[client_id waiter_id table_id status]
    end

    def total
      prices = dishes.map { |dish| dish.price.to_i * dish.quantity.to_i }
      prices.reduce(:+)
    end

    def send_to_kitchen
      update(status: 'IN_KITCHEN')
      update(send_to_kitchen_at: DateTime.now)
    end

    def self.current_orders
      today_orders.where("status = 'ACTIVE' or status = 'IN_KITCHEN'")
    end

    def self.foods_in_kitchen
      today_orders.where(status: 'IN_KITCHEN').order(id: :asc)
    end

    def self.drinks_in_bar
      today_orders.where(status: 'IN_KITCHEN').select do |order|
        order.dishes.select { |dish| !dish.is_drink? }
      end
    end

    def foods
      dishes.select { |dish| !dish.is_drink? }
    end

    def drinks
      dishes.select { |dish| dish.is_drink? }
    end

    def self.completed_orders
      foods_in_kitchen.select do |order|
        completed_foods = order.foods.map { |f| f if f.completed? && !f.cancelled? }.compact.count
        foods_count = order.foods.map { |f| f if !f.cancelled? }.compact.count
        order if foods_count.eql?(completed_foods)
      end
    end

    def self.incompleted_orders
      foods_in_kitchen.select do |order|
        completed_foods = order.foods.map { |f| f if f.completed? && !f.cancelled? }.compact.count
        foods_count = order.foods.map { |f| f if !f.cancelled? }.compact.count
        order if !foods_count.eql?(completed_foods)
      end
    end

    def self.incompleted_drinks
      foods_in_kitchen.select do |order|
        ids = order.drinks.map(&:id)
        completed_drinks = order.dishes.where(id: ids, completed: true).count
        order if !completed_drinks.eql?(order.drinks.count)
      end.reverse
    end

    def percentage
      completed = foods.map { |f| f if f.completed? && !f.cancelled? }.compact.count
      foods_count = foods.map { |f| f if !f.cancelled? }.compact.count
      return 0 if completed.zero? || foods_count.zero?
      ((completed * 100) / foods_count)
    end

    def in_kitchen?
      status.eql?('IN_KITCHEN')
    end

    def self.current_period_id
      KepplerPeriods::Period&.current_period&.id
    end

    def created_time
      send_to_kitchen_at&.time&.strftime("%I:%M %p")
    end

    def completed_time
      return unless dishes.where(completed: true).count.eql?(dishes.count)
      dishes.pluck(:completed_at).compact.max.strftime("%I:%M %p")
    end

    def completed
      dishes.where(completed: true).count.eql?(dishes.count)
    end

    def cancel
      toggle!(:cancelled)
      dishes.update_all(cancelled: true)
      update(cancelled_at: DateTime.now)
    end

    def get_minutes
      seconds = (Time.now - send_to_kitchen_at).to_i
      minuts = (seconds / 60)
    end

    def cancelled_time
      seconds = (Time.now - cancelled_at).to_i
      (seconds / 60)
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
