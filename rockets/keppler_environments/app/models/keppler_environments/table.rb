module KepplerEnvironments
  class Table < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'idconsumos'
    self.primary_key = :id_consumo

    has_many :accounts, class_name: 'KepplerOrders::Account'

    def self.available_tables(section_id)
      busy_tables       = Section.where.not(id: section_id).map(&:tables).flatten.compact
      available_tables  = where.not(id_consumo: busy_tables).map(&:id_consumo)
    end

    def today_accounts
      accounts.where(period_id: current_period_id)
    end

    def current_accounts
      today_accounts.where(period_id: current_period_id)
    end

    private

    def current_period_id
      KepplerPeriods::Period&.current_period&.id
    end
  end
end
