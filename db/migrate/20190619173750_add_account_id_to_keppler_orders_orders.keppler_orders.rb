# This migration comes from keppler_orders (originally 20190619173737)
class AddAccountIdToKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :account_id, :integer
  end
end
