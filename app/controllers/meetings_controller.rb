class MeetingsController < ApplicationController
  def index
    @meetings_as_helper = Meeting.where("helper_id = ?", current_user.id)
    @meetings_as_helper_pending = @meetings_as_helper.where("status = 'pending approval'")
    @meetings_as_helper_coming = @meetings_as_helper.where("status = 'accepted'")
    @meetings_as_helper_done = @meetings_as_helper.where("status = 'pending review'")
    @meetings_as_helper_finished = @meetings_as_helper.where("status = 'finished'")
    @meetings_as_helpee = Meeting.where("helpee_id = ?", current_user.id)
    @meetings_as_helpee_pending = @meetings_as_helpee.where("status = 'pending approval'")
    @meetings_as_helpee_coming = @meetings_as_helpee.where("status = 'accepted'")
    @meetings_as_helpee_done = @meetings_as_helpee.where("status = 'pending review'")
    @meetings_as_helpee_finished = @meetings_as_helpee.where("status = 'finished'")
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
      Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Meeting créé ! Utilisez cette chatbox pour s'accorder sur une date et une durée. #{@meeting.helper.first_name} devra ensuite valider la demande.")
      redirect_to meetings_path
    else
      render 'profile/show_private'
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      if @meeting.status == "refused"
        @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Meeting refusé.")
      elsif @meeting.status == "accepted"
        @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Meeting accepté. Bon échange !")
      elsif @meeting.status == "cancelled"
        @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Meeting annulé.")
      elsif @meeting.status == "pending review"
        @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Le meeting s'est bien passé ? #{@meeting.helpee.first_name} doit laisser un avis pour que le crédit temps soit validé !")
      elsif @meeting.status == "finished"
        @message = Message.create(meeting: @meeting, sender: @meeting.helper, receiver: @meeting.helpee, status: "auto", description: "Le meeting est terminé. Merci d'avoir contribué !")
      end
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:status, :date, :duration)
  end

end
