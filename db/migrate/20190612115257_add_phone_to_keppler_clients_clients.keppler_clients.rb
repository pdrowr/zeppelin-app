# This migration comes from keppler_clients (originally 20190612115224)
class AddPhoneToKepplerClientsClients < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_clients_clients, :phone, :string
  end
end
