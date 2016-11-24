class ChangeDefaultValueMembership < ActiveRecord::Migration
  def change
    change_column :memberships, :status, :string, default: "pending_approval"
  end
end
