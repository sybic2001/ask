class UserCompetency < ActiveRecord::Base
  belongs_to :user
  belongs_to :competency
end
