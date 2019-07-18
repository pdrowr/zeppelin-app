# This migration comes from keppler_orders (originally 20190718170848)
class AddReferenceToKepplerOrdersAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_orders_accounts, :reference, :string
  end
end
