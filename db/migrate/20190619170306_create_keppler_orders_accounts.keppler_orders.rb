# This migration comes from keppler_orders (originally 20190619165152)
class CreateKepplerOrdersAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_orders_accounts do |t|
      t.string :client_id
      t.string :waiter_id
      t.string :table_id
      t.string :period_id
      t.boolean :cancelled
      t.datetime :completed_at
      t.string :status

      t.timestamps
    end
  end
end
