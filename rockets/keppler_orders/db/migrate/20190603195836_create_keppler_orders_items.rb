class CreateKepplerOrdersItems < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_orders_items do |t|
      t.string :order_id
      t.string :dish_id
      t.string :price
      t.integer :quantity
      t.text :observation
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
