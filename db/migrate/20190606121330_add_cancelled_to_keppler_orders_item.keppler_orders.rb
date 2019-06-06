# This migration comes from keppler_orders (originally 20190606121225)
class AddCancelledToKepplerOrdersItem < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_items, :cancelled, :boolean, default: false
  end
end
