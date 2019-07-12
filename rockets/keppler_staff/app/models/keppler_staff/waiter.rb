# frozen_string_literal: true

module KepplerStaff
  # Member Model
  class Waiter < KepplerStaff::Member
    has_many :accounts, class_name: 'KepplerOrders::Account'

    def today_accounts
      accounts.where(period_id: current_period_id)
    end

    def current_accounts
      today_accounts.where("status = 'ACTIVE' or status = 'IN_KITCHEN'")
    end

    private

    def current_period_id
      KepplerPeriods::Period&.current_period&.id
    end
  end
end
