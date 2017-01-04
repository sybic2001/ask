class Competency < ActiveRecord::Base
  belongs_to :parent_competency, class_name: "Competency"
  has_many :child_competencies, class_name: "Competency", foreign_key: "parent_competency_id", dependent: :destroy
  has_many :user_competencies, dependent: :destroy
  has_many :badges, dependent: :destroy
  has_many :badge_user_competencies, through: :badges, source: :user_competency

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.parent_competencies
    Competency.where(parent_competency_id: nil)
  end

  def i18name
    I18n.t("competencies.#{self.ref}")
  end

  def self.child_competencies
    Competency.where(parent_competency: Competency.parent_competencies)
  end

  def self.badge_competencies
    Competency.where(parent_competency: Competency.child_competencies)
  end
end
