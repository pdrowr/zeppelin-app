module KepplerEnvironments
  class Table < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'idconsumos'
  end
end
