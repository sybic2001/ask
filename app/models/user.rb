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
end
