class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.references :user_competency, index: true, foreign_key: true
      t.references :competency, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
