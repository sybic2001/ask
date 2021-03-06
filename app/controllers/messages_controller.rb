class MessagesController < ApplicationController
  def index
    @meeting = Meeting.includes(:messages).find(params[:meeting_id])
    @messages = @meeting.messages
    @messages.where(receiver: current_user, status: 'new').update_all(status: 'read')
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @meeting = Meeting.find(params[:meeting_id])
    @message.meeting = @meeting
    @message.sender = current_user
    @message.status = "new"
    if @meeting.helper == current_user
      @message.receiver = @meeting.helpee
    else
      @message.receiver = @meeting.helper
    end
    @message.save
  end

  def delete
  end

  private

  def message_params
    params.require(:message).permit(:description, :meeting)
  end
end
