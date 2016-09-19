class Competency < ActiveRecord::Base
  include AlgoliaSearch
  belongs_to :parent_competency, class_name: "Competency"
  has_many :child_competencies, class_name: "Competency", foreign_key: "parent_competency_id", dependent: :destroy
  has_many :user_competencies, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

  algoliasearch do
    attribute :name
  end

  def self.parent_competencies
    Competency.all.where(parent_competency_id: nil)
  end

end
