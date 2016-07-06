class RemovePhotoToCommunity < ActiveRecord::Migration
  def change
    remove_column :communities, :photo, :string
  end
end
