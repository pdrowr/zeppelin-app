# This migration comes from keppler_orders (originally 20190703141759)
class AddCancelledAtToKepplerOrdersAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_accounts, :cancelled_at, :datetime
  end
end
