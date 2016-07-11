class MessagesController < ApplicationController
  def index
    @meeting = Meeting.find(params[:meeting_id])
    @messages = @meeting.messages
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @meeting = Meeting.find(params[:meeting_id])
    @message.meeting = @meeting
    @message.sender = current_user
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
    params.require(:message).permit(:description)
  end
end
