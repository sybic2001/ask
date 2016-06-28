class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :meetings, dependent: :destroy
  has_many :user_competencies, dependent: :destroy

  validates :email, :first_name, :last_name, presence: true

  before_create :build_default_profile

  private

  def build_default_profile
  # build default profile instance. Will use default params.
  # The foreign key to the owning User model is set automatically
  build_profile
  true # Always return true in callbacks as the normal 'continue' state
       # Assumes that the default_profile can **always** be created.
       # or
       # Check the validation of the profile. If it is not valid, then
       # return false from the callback. Best to use a before_validation
       # if doing this. View code should check the errors of the child.
       # Or add the child's errors to the User model's error array of the :base
       # error item
  end
end
