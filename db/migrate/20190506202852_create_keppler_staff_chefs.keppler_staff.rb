# This migration comes from keppler_staff (originally 20190506202849)
class CreateKepplerStaffChefs < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_staff_chefs do |t|
      t.string :avatar
      t.string :name
      t.string :username
      t.string :email
      t.string :code
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
