class AddManagerCodeToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :manager_code, :string, default: '12345'
  end
end
