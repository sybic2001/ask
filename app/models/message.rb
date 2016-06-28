class Message < ActiveRecord::Base
  belongs_to :meeting

  validates :meeting, :description, :author_id, presence: true
end
