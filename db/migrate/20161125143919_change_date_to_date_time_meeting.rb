class ChangeDateToDateTimeMeeting < ActiveRecord::Migration
  def change
    change_column :meetings, :date, :datetime
  end
end
