class UserCompetency < ActiveRecord::Base
  belongs_to :user
  belongs_to :competency

  validates :user, :competency, :level, presence: true
end
