class Community < ActiveRecord::Base
  include AlgoliaSearch
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :user_competencies, through: :users
  has_attachment :photo

  validates :name, presence: true
  validates :name, uniqueness: true

  algoliasearch do
    attribute :name
  end

end
