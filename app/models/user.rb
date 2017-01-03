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
  has_many :favorite_user_competencies, -> { distinct }, through: :favorites, source: :user_competency
  has_many :users, -> { distinct }, through: :communities
  has_many :peer_competencies, -> { distinct }, through: :users, source: :user_competencies

  validates :email, :first_name, :last_name, presence: true

  after_create :build_default_profile, :welcome_email

  def is_community_manager?(community)
    user_membership = self.memberships.find_by(community: community)
    return !user_membership.nil? && user_membership.community_manager
  end

  def is_member?(community)
    user_membership = self.memberships.find_by(community: community)
    return !user_membership.nil? && (user_membership.status == "member")
  end

  def total_given
    self.helper_meetings.where(status: 'finished').sum(:duration).to_i
  end

  def average_rating
    self.reviews.average(:user_rating).to_i
  end

  def pending_meetings_nb
    Meeting.where("(helper_id = ? OR helpee_id = ?) AND status = ?", self.id, self.id, "pending_approval").count
  end

  def next_meeting
    Meeting.where("(helper_id = ? OR helpee_id = ?) AND status = ?", self.id, self.id, "accepted").order(:date).first
  end

  def peers
    self.users.joins(:memberships).where(memberships: {status: "member"}) - [self]
  end

  def promo_peers(community_id)
    my_promo = self.memberships.where(community_id: community_id).pluck(:promotion)
    User.joins(:memberships).where(memberships: {community_id: community_id, promotion: my_promo, status: "member"}) - [self]
  end

  def peers_cities
    self.users.joins(:memberships, :profile).where(memberships: {status: "member"}).pluck(:'profiles.city').reject(&:empty?)
  end

  private

  def build_default_profile
    Profile.create(first_name: self.first_name, last_name: self.last_name, user: self)
  end

  def welcome_email
    UserMailer.welcome(self).deliver_now
  end


end
