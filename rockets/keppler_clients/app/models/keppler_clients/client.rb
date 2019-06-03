# frozen_string_literal: true

module KepplerClients
  # Client Model
  class Client < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    acts_as_list
    acts_as_paranoid
    has_many :orders, class_name: 'KepplerOrders::Order'

    def self.index_attributes
      %i[name identification email address code]
    end

    def create_order(table_id, waiter_id)
      orders.create!(
        table_id: table_id,
        waiter_id: waiter_id,
        status: 'ACTIVE'
      )
    end
  end
end
