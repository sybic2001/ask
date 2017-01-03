class AddRefToCompetency < ActiveRecord::Migration
  def change
    add_column :competencies, :ref, :integer
  end
end
