# frozen_string_literal: true

module KepplerOrders
  # Item Model
  class Item < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    acts_as_list
    acts_as_paranoid


    def self.index_attributes
      %i[order_id dish_id price]
    end

    def dish
      KepplerMenu::Dish.find(dish_id)
    end

    def toggle_item
      update(completed_at: DateTime.now)
      toggle!(:completed)
    end

    def is_drink?
      dish.is_drink?
    end
  end
end
