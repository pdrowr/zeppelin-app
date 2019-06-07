# This migration comes from keppler_orders (originally 20190607122404)
class AddCompletedAtToKepplerOrdersItems < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_items, :completed_at, :datetime
  end
end
