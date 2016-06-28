class Community < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  validates :name, :membership, presence: true
  validates :name, uniqueness: true
end
