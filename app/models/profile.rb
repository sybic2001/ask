class Profile < ActiveRecord::Base
  belongs_to :user

  validates :city, :phone_number, presence: true
end
