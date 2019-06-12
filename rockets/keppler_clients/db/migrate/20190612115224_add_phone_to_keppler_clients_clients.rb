class AddPhoneToKepplerClientsClients < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_clients_clients, :phone, :string
  end
end
