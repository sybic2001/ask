class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :user_competency, index: true, foreign_key: true
      t.string :company
      t.string :project
      t.string :description
      t.integer :year
      t.integer :duration

      t.timestamps null: false
    end
  end
end
