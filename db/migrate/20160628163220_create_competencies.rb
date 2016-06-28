class CreateCompetencies < ActiveRecord::Migration
  def change
    create_table :competencies do |t|
      t.string :name
      t.string :description
      t.references :competency, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
