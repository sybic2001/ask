class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :meeting, index: true, foreign_key: true
      t.string :description
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
