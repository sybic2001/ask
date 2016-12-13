class AddDefaultValueToProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :total_time_credit, :integer, default: 10
  end
end
