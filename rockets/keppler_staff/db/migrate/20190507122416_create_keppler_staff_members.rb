class CreateKepplerStaffMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_staff_members do |t|
      t.string :picture
      t.string :name
      t.string :alias
      t.string :email
      t.string :member_code
      t.string :type
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
