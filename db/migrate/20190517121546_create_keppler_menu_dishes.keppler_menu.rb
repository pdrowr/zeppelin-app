# This migration comes from keppler_menu (originally 20190517121542)
class CreateKepplerMenuDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_menu_dishes do |t|
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
