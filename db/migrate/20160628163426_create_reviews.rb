class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :meeting, index: true, foreign_key: true
      t.integer :user_rating
      t.string :user_comment
      t.integer :competency_rating
      t.string :competency_comment

      t.timestamps null: false
    end
  end
end
