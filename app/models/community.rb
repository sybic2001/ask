class Community < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  validates :name, presence: true
  validates :name, uniqueness: true
end
