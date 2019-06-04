# frozen_string_literal: true

module KepplerMenu
  # Dish Model
  class Dish < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    # include Sortable
    include Searchable
    # acts_as_list
    # acts_as_paranoid

    establish_connection :premium_database_development
    self.table_name = 'articulo'
    belongs_to :category, foreign_key: 'grupo', class_name: 'KepplerMenu::Category'
    has_many :pictures, as: :picturable

    def name
      self.nombre.strip
    end

    def category_name
      self.category.name
    end

    def dish_id
      self.id.strip
    end

    def price
      self.precio1
    end

    def self.index_attributes
      %i[]
    end

    def picture
      pictures.first.present? ? pictures.first.picture.url : '/assets/app/product'
    end
  end
end
