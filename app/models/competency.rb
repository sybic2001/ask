class Competency < ActiveRecord::Base
  belongs_to :parent_competency, class_name: "Competency"
  has_many :child_competencies, class_name: "Competency", foreign_key: "parent_competency_id", dependent: :destroy
  has_many :user_competencies, dependent: :destroy

  validates :name, :description, presence: true
  validates :name, uniqueness: true

end
