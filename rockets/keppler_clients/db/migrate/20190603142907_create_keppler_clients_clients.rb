class CreateKepplerClientsClients < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_clients_clients do |t|
      t.string :name
      t.string :identification
      t.string :email
      t.string :address
      t.string :code
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
