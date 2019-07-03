class AddCancelledAtToKepplerOrdersAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_accounts, :cancelled_at, :datetime
  end
end
