class CreateKepplerMenuPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_menu_pictures do |t|
      t.jsonb :picture
      t.integer :picturable_id
      t.string :picturable_type

      t.timestamps
    end
  end
end
