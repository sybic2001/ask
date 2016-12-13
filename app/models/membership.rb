class Membership < ActiveRecord::Base
  belongs_to :community
  belongs_to :user

  validates :community, :user, :status, :promotion, presence: true
  validates :community, uniqueness: { scope: :user }
  validates :status, inclusion: { in: ["pending_approval","member","refused","left","excluded"]}
end
