class ChangeDefaultForMembership < ActiveRecord::Migration
  def change
    change_column :memberships, :community_manager, :boolean, default: false
    change_column :memberships, :community_time_credit, :integer, default: 2
    change_column :memberships, :status, :string, default: "pending approval"
  end
end
