module KepplerEnvironments
  class Table < ApplicationRecord
    establish_connection :premium_database_development
    self.table_name = 'idconsumos'
    self.primary_key = :id_consumo

    has_many :orders, class_name: 'KepplerOrders::Order'

    def self.available_tables(section_id)
      busy_tables       = Section.where.not(id: section_id).map(&:tables).flatten.compact
      available_tables  = where.not(id_consumo: busy_tables).map(&:id_consumo)
    end

    def orders
      KepplerOrders::Order.where(table_id: id_consumo).includes(:dishes)
    end

    def today_orders
      orders.where(period_id: current_period_id)
    end

    def current_orders
      today_orders.where("status = 'ACTIVE' or status = 'IN_KITCHEN'")
                  .includes(:dishes)
    end

    private

    def current_period_id
      KepplerPeriods::Period&.current_period&.id
    end
  end
end
