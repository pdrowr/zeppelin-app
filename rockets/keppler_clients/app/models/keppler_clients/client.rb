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

    has_many :accounts, class_name: 'KepplerOrders::Account'

    validates_presence_of :name, :email, :identification
    validates_uniqueness_of :email, :identification

    def self.index_attributes
      %i[name identification email address code]
    end

    def create_account(table_id, waiter_id, period_id)
      account = accounts.create(
        table_id: table_id,
        waiter_id: waiter_id,
        status: 'ACTIVE',
        period_id: period_id
      )
    end

    def have_active_account?(table)
      !accounts.where(period_id: current_period_id, table_id: table).first.blank?
    end

    def self.set_client(client_params)
      where(identification: client_params[:identification]).first_or_create(client_params)
    end

    private

    def current_period_id
      KepplerPeriods::Period&.current_period&.id
    end

  end
end
