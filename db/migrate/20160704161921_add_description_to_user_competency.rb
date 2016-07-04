class AddDescriptionToUserCompetency < ActiveRecord::Migration
  def change
    add_column :user_competencies, :description, :text
  end
end
