class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :user_competencies, dependent: :destroy
  has_many :competencies, through: :user_competencies
  has_many :communities, through: :memberships
  has_many :experiences, through: :user_competencies
  has_many :sended_messages, :class_name => "Message", :foreign_key => "sender_id"
  has_many :received_messages, :class_name => "Message", :foreign_key => "receiver_id"
  has_many :helper_meetings, class_name: "Meeting", foreign_key: "helper_id", dependent: :destroy
  has_many :helpee_meetings, class_name: "Meeting", foreign_key: "helpee_id", dependent: :destroy
  has_many :reviews, through: :helper_meetings
  has_many :favorites, dependent: :destroy

  validates :email, :first_name, :last_name, presence: true

  after_create :build_default_profile

  private

  def build_default_profile
    Profile.create(first_name: self.first_name, last_name: self.last_name, user: self)
  end

end
