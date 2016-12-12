class Review < ActiveRecord::Base
  belongs_to :meeting

  validates :meeting, :user_rating, :user_comment, :competency_rating, presence: true
end
