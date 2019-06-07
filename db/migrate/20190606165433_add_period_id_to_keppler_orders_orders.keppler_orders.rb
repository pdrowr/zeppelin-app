# This migration comes from keppler_orders (originally 20190606165421)
class AddPeriodIdToKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :period_id, :integer
  end
end
