class UserCompetency < ActiveRecord::Base
  belongs_to :user
  belongs_to :competency
  has_many :experiences, dependent: :destroy
  has_many :meetings, dependent: :destroy
  has_many :reviews, through: :meetings
  has_many :favorites, dependent: :destroy
  has_many :communities, through: :user

  validates :user, :competency, :level, :description, presence: true
  validates :competency, uniqueness: { scope: :user }

end
