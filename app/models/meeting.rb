class Meeting < ActiveRecord::Base
  belongs_to :user_competency
  belongs_to :helper, :class_name => "User"
  belongs_to :helpee, :class_name => "User"
  has_many :reviews, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :helpee, :user_competency, :helper, :status, presence: true
  validates :date, :duration, presence: true, if: "(status == 'accepted')"
  validates :status, inclusion: { in: ["pending_approval","accepted","refused","pending_review","cancelled","finished"], message: "Invalid status"}

  before_create do
    self.helper_id = self.user_competency.user_id if self.helper_id.nil?
  end

  after_create :new_meeting_email

  def active?
    ["pending_approval", "accepted", "pending review"].include?(self.status)
  end

  def new_messages(user)
    self.messages.where(receiver: user, status: "new").count
  end

  def new_meeting_email
    UserMailer.new_meeting(self).deliver_now
  end
end
