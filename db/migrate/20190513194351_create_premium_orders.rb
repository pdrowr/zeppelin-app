class CreatePremiumOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :premium_orders do |t|

      t.timestamps
    end
  end
end
