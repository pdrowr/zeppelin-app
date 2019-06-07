class AddCompletedAtToKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :completed_at, :date
  end
end
