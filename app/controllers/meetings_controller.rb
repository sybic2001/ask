class MeetingsController < ApplicationController
  def index
    @meetings_as_helper = Meeting.where("helper_id = ?", current_user.id)
    @meetings_as_helpee = Meeting.where("helpee_id = ?", current_user.id)
    @meetings = @meetings_as_helper + @meetings_as_helpee
    @message = Message.new()
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
