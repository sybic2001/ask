class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.includes(:helper, :helpee, [user_competency: :competency]).where("helper_id = ? OR helpee_id = ?", current_user.id, current_user.id)
    @pending_meetings = @meetings.where(status: "pending_approval")
    @agenda_meetings = @meetings.where(status: "accepted").order(:date)
    @pending_review_meetings = @meetings.where(status: "pending_review").order(:date)
    @finished_meetings = @meetings.where(status: "finished").order(:date)
    # @meetings_as_helper = Meeting.where("helper_id = ?", current_user.id)
    @message = Message.new()
  end

  def create
    @user_competency = UserCompetency.find(params[:user_competency_id])
    @meeting = Meeting.new
    @meeting.user_competency = @user_competency
    @meeting.helpee_id = current_user.id
    @meeting.helper_id = @user_competency.user_id
    @meeting.status = "pending_approval"
    if @meeting.save
      Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "meeting_created")
      redirect_to meetings_path
    else
      render 'profile/show'
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    current_status = @meeting.status
    params[:meeting][:status] = "accepted" if params[:commit].has_key?('accept')
    params[:meeting][:status] = "cancelled" if params[:commit].has_key?('cancel')
    if @meeting.update(meeting_params)
      if current_status != @meeting.status
        if @meeting.status == "refused"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "meeting_refused")
        elsif @meeting.status == "accepted"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "meeting_accepted")
        elsif @meeting.status == "cancelled"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "meeting_cancelled")
        elsif @meeting.status == "pending_review"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "pending_review")
        elsif @meeting.status == "finished"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "meeting_finished")
        end
      end
    else
      render nothing: true
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:status, :date, :duration)
  end

end
