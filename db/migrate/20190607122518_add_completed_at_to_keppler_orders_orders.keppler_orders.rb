# This migration comes from keppler_orders (originally 20190607122354)
class AddCompletedAtToKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :completed_at, :datetime
  end
end
