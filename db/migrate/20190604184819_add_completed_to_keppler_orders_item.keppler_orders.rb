# This migration comes from keppler_orders (originally 20190604184751)
class AddCompletedToKepplerOrdersItem < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_items, :completed, :boolean, default: false
  end
end
