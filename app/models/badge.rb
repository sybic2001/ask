class Badge < ActiveRecord::Base
  belongs_to :user_competency
  belongs_to :competency
end
