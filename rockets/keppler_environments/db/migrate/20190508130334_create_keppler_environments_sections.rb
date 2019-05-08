class CreateKepplerEnvironmentsSections < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_environments_sections do |t|
      t.string :name
      t.string :cover
      t.jsonb :table_ids
      t.boolean :active
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
