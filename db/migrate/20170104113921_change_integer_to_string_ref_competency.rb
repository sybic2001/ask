class ChangeIntegerToStringRefCompetency < ActiveRecord::Migration
  def change
    change_column :competencies, :ref, :string
  end
end
