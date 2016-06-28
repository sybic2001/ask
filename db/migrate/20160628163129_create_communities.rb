class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :photo

      t.timestamps null: false
    end
  end
end
