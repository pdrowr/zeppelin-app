# This migration comes from keppler_orders (originally 20190611205448)
class AddSendToKitchenAtToKepplerOrdersOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_orders, :send_to_kitchen_at, :datetime
  end
end
