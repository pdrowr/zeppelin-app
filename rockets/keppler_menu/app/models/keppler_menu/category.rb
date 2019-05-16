# frozen_string_literal: true

module KepplerMenu
  # Category Model
  class Category < ApplicationRecord

    establish_connection :premium_database_development
    self.table_name = 'grupos'

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
      self.codigo.strip
    end

    def name
      self.nombre.strip
    end

    def category_id
      self.id.strip
    end
  end
end
