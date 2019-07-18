# This migration comes from keppler_orders (originally 20190718141423)
class CreateKepplerOrdersPremiumOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_orders_premium_orders do |t|

      t.timestamps
    end
  end
end
