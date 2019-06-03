module KepplerEnvironments
  class Table < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'idconsumos'
    self.primary_key = :id_consumo

    has_many :orders, class_name: 'KepplerOrders::Order'

    def self.available_tables
      busy_tables       = Section.all.map(&:tables).flatten.compact
      available_tables  = where.not(id_consumo: busy_tables).map(&:id_consumo)
    end

    def orders
      KepplerOrders::Order.where(table_id: id_consumo)
    end

    def current_orders
      orders.where(
        created_at: today,
        status: 'ACTIVE'
      ).order(id: :desc)
    end

    private

    def today
      Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    end

  end
end
