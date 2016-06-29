class RemoveForeignKeyFromCompetency < ActiveRecord::Migration
  def change
    remove_foreign_key :competencies, :competencies
  end
end
