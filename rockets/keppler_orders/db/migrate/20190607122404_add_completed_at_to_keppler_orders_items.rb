class AddCompletedAtToKepplerOrdersItems < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_items, :completed_at, :date
  end
end
