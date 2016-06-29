class ChangeHelperInMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :teacher_id, :integer
    remove_column :meetings, :user_id
    add_column :meetings, :helper_id, :integer
    add_column :meetings, :helpee_id, :integer
  end
end
