class CreateKepplerOrdersPremiumItems < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_orders_premium_items do |t|

      t.timestamps
    end
  end
end
