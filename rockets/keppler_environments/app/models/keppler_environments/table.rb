module KepplerEnvironments
  class Table < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'idconsumos'

    def self.available_tables
      busy_tables       = Section.all.map(&:tables).flatten.compact
      available_tables  = where.not(id_consumo: busy_tables).map(&:id_consumo)
    end
  end
end
