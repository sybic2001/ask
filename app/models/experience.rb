class Experience < ActiveRecord::Base
  belongs_to :user_competency

  validates :description, :year, :duration, :user_competency, presence: true
end
