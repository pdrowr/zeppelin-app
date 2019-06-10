# frozen_string_literal: true

module KepplerMenu
  # Category Model
  class Category < ApplicationRecord

    establish_connection :premium_database_development
    self.table_name = 'grupos'
    has_many :dishes, foreign_key: 'grupo', class_name: 'KepplerMenu::Dish'

    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Searchable

    has_many :pictures, as: :picturable

    def self.index_attributes
      %i[code name]
    end

    def code
      codigo.strip
    end

    def name
      nombre.strip
    end

    def dishes_count
      dishes.count
    end

    def category_id
      id.strip
    end

    def picture
      pictures.first.present? ? pictures.first.picture.url : '/assets/app/category'
    end

    def drinks
      ["tragos", "bebidas sin alcohol", "cafe", "promos bebida"]
    end

    def is_drink?
      drinks.include?(name.downcase)
    end

  end
end
