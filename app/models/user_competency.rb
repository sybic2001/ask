class UserCompetency < ActiveRecord::Base
  include AlgoliaSearch
  belongs_to :user
  belongs_to :competency
  has_many :experiences, dependent: :destroy
  has_many :meetings, dependent: :destroy
  has_many :reviews, through: :meetings
  has_many :favorites

  validates :user, :competency, :level, :description, presence: true
  validates :competency, uniqueness: { scope: :user }

  algoliasearch do
    attribute :user, :competency, :level
  end
end
