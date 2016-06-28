class Meeting < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_competency
  has_many :reviews, dependent: :destroy
  has_many :messages, dependant: :destroy

  validates :user, :user_competency, :date, :duration, :status, presence: true
end
