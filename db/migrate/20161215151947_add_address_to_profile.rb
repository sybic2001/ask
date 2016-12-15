class AddAddressToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :country, :string
    add_column :profiles, :state, :string
    add_column :profiles, :zip_code, :string
  end
end
