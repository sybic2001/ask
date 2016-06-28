class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :total_time_credit
      t.string :address
      t.string :city
      t.string :phone_number
      t.string :photo

      t.timestamps null: false
    end
  end
end
