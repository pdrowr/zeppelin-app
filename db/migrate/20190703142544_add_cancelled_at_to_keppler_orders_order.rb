class AddCancelledAtToKepplerOrdersOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :cancelled_at, :datetime
  end
end
