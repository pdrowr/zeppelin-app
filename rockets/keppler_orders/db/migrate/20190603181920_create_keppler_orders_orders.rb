class CreateKepplerOrdersOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_orders_orders do |t|
      t.string :client_id
      t.string :waiter_id
      t.string :table_id
      t.string :status
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
