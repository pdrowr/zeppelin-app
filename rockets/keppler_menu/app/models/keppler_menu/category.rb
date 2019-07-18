# frozen_string_literal: true

module KepplerMenu
  # Category Model
  class Category < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'grupos'

    has_many :dishes, foreign_key: 'grupo', class_name: 'KepplerMenu::Dish'
    has_many :pictures, as: :picturable

    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Searchable

    def self.index_attributes
      %i[code name]
    end

    def code
      codigo.strip
    end

    def name
      nombre.strip
    end

    def category_id
      id.strip
    end

    def picture
      pictures.first.present? ? pictures.first.picture.url : '/assets/app/category'
    end

    def is_drink?
      !eslicores.zero?
    end

  end
end
