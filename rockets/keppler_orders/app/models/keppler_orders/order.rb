# frozen_string_literal: true

module KepplerOrders
  # Order Model
  class Order < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    acts_as_list
    acts_as_paranoid

    belongs_to :client, class_name: 'KepplerClients::Client'
    belongs_to :waiter, class_name: 'KepplerStaff::Waiter'
    belongs_to :table, class_name: 'KepplerEnvironments::Table'
    has_many :dishes, class_name: 'KepplerOrders::Item'

    def self.index_attributes
      %i[client_id waiter_id table_id status]
    end

    def total
      price = dishes.map { |dish| dish.price.to_i * dish.quantity.to_i }
      price.reduce(:+)
    end
  end
end
