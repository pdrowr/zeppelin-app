class CreateKepplerEnvironmentsTables < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_environments_tables do |t|

      t.timestamps
    end
  end
end
