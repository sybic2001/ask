class Message < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  validates :description, :sender_id, :receiver_id, presence: true
  validates :status, inclusion: { in: ["read","new","auto"], message: "Invalid status"}
end
