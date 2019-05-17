class PremiumOrder < ApplicationRecord
  establish_connection :premium_database_development
  self.table_name = 'articulo'
end
