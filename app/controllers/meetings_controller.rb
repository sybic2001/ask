class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.where("helper_id = ? OR helpee_id = ?", current_user.id, current_user.id)
  end

  def create
    @user_competency = UserCompetency.find(params[:user_competency_id])
    @meeting = Meeting.new
    @meeting.user_competency = @user_competency
    @meeting.helpee_id = current_user.id
    @meeting.helper_id = @user_competency.user_id
    @meeting.status = "pending approval"
    if @meeting.save
      redirect_to meetings_path
    else
      render 'profile/show_private'
    end
  end
end
