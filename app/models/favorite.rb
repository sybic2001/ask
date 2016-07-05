class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_competency

  validates :user, :user_competency, presence: true
  validates :user_competency, uniqueness: { scope: :user }
end
