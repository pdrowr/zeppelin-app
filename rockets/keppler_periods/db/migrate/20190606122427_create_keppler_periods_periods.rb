class CreateKepplerPeriodsPeriods < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_periods_periods do |t|
      t.string :name
      t.date :date
      t.boolean :open, default: true
      t.integer :position
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
