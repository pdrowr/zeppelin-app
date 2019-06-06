class AddCancelledToKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :cancelled, :boolean
  end
end
