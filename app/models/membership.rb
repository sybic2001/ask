class Membership < ActiveRecord::Base
  belongs_to :community
  belongs_to :user

  validates :community, :user, :status, presence: true
end
