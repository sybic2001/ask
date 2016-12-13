class AddPromoToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :promotion, :string
  end
end
