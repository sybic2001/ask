class RenameCompetencyInCompetencies < ActiveRecord::Migration
  def change
    remove_column :competencies, :competency_id
    add_column :competencies, :parent_competency_id, :integer
  end
end
