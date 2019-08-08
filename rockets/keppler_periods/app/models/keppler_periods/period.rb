# frozen_string_literal: true

module KepplerPeriods
  # Period Model
  class Period < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    acts_as_list
    acts_as_paranoid

    validates_presence_of :date
    has_many :accounts, class_name: 'KepplerOrders::Account'

    def self.current_period
      where(open: true)&.first || nil
    end

    def self.index_attributes
      %i[name]
    end

    def subtotal
      orders_total = accounts.map { |a| a.orders.map(&:total).compact.sum }
      total = orders_total.sum
    end

    def iva
      return 0 if subtotal.nil?
      subtotal * 0.12
    end

    def total
      return 0 if subtotal.nil?
      subtotal + iva
    end
  end
end
