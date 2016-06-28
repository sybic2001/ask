class Competency < ActiveRecord::Base
  belongs_to :competency
  has_many :competencies, dependent: :destroy
  has_many :user_competencies, dependent: :destroy

  validates :name, :description, presence: true
  validates :name, uniqueness: true

end
