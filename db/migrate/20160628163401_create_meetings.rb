class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :teacher_id
      t.date :date
      t.integer :duration
      t.string :status
      t.references :user_competency, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
