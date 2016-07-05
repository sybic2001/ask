class UserCompetency < ActiveRecord::Base
  belongs_to :user
  belongs_to :competency
  has_many :experiences, dependent: :destroy
  has_many :meetings
  has_many :reviews, through: :meetings
  has_many :favorites

  validates :user, :competency, :level, :description, presence: true
  validates :competency, uniqueness: { scope: :user }
end
