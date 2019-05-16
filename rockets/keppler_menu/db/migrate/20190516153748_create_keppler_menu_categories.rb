class CreateKepplerMenuCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_menu_categories do |t|
      t.string :code
      t.string :name
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
