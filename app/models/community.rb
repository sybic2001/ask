class Community < ActiveRecord::Base
  include AlgoliaSearch
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :user_competencies, through: :users
  has_many :competencies, through: :user_competencies
  has_attachment :photo

  validates :name, presence: true
  validates :name, uniqueness: true

  algoliasearch do
    attributes :name, :members_count

    attributesToIndex ['name']

    customRanking ['desc(members_count)']
  end

  def members_count
    self.memberships.where(status: 'member').count
  end

end
