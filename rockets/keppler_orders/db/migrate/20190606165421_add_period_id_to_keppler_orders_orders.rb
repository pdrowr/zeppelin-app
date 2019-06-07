class AddPeriodIdToKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :period_id, :integer
  end
end
