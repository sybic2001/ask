class UserCompetency < ActiveRecord::Base
  belongs_to :user
  belongs_to :competency
  has_many :experiences
  has_many :meetings
  has_many :reviews, through: :meetings

  validates :user, :competency, :level, presence: true
end
