# This migration comes from keppler_orders (originally 20190606121525)
class AddCancelledToKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :cancelled, :boolean, default: false
  end
end
