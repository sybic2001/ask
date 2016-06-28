class Meeting < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_competency
end
