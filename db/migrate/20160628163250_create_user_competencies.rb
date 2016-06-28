class CreateUserCompetencies < ActiveRecord::Migration
  def change
    create_table :user_competencies do |t|
      t.references :user, index: true, foreign_key: true
      t.references :competency, index: true, foreign_key: true
      t.integer :level

      t.timestamps null: false
    end
  end
end
