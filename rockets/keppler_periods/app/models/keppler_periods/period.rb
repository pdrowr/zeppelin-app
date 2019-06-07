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

    validates_presence_of :name, :date
    has_many :orders, class_name: 'KepplerOrders::Order'

    def self.current_period
      where(open: true)&.first || nil
    end

    def self.index_attributes
      %i[name]
    end
  end
end
