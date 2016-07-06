class RemovePhotoFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :photo, :string
    add_column :profiles, :first_name, :string
    add_column :profiles, :last_name, :string
  end
end
