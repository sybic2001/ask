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
      Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Meeting créé ! Utilisez cette chatbox pour s'accorder sur une date et une durée. #{@meeting.helper.first_name} devra ensuite valider la demande.")
      redirect_to meetings_path
    else
      render 'profile/show'
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    current_status = @meeting.status
    if @meeting.update(meeting_params)
      if current_status != @meeting.status
        if @meeting.status == "refused"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Meeting refusé.")
        elsif @meeting.status == "accepted"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Meeting accepté. Bon échange !")
        elsif @meeting.status == "cancelled"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Meeting annulé.")
        elsif @meeting.status == "pending_review"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Le meeting s'est bien passé ? #{@meeting.helpee.first_name} doit laisser un avis pour que le crédit temps soit validé !")
        elsif @meeting.status == "finished"
          @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Le meeting est terminé. Merci d'avoir contribué !")
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
