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

    def create_order(table_id, waiter_id, period_id)
      orders.create(
        table_id: table_id,
        waiter_id: waiter_id,
        status: 'ACTIVE',
        period_id: period_id
      )
    end

    def self.set_client(client_params)
      where(email: client_params[:email]).first_or_create(client_params)
    end

  end
end
