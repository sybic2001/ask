class Meeting < ActiveRecord::Base
  belongs_to :user_competency
  belongs_to :helper, :class_name => "User"
  belongs_to :helpee, :class_name => "User"
  has_many :reviews, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :helpee, :user_competency, :helper, :status, presence: true
  validates :status, inclusion: { in: ["pending approval","accepted","refused","pending review","cancelled","finished"], message: "Invalid status"}

  before_create do
    self.helper_id = self.user_competency.user_id if self.helper_id.nil?
  end

end
