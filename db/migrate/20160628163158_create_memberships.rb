class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :community, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :status
      t.integer :community_time_credit
      t.boolean :community_manager

      t.timestamps null: false
    end
  end
end
