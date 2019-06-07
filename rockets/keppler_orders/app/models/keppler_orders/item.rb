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
      toggle!(:completed)
      update(completed_at: DateTime.new)
    end

  end
end
