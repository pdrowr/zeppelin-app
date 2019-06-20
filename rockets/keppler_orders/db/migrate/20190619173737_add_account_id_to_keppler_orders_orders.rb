class AddAccountIdToKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :account_id, :integer
  end
end
