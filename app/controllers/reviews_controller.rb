class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @meeting = Meeting.find(params[:meeting_id])
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      Message.create(meeting: @review.meeting, sender: @review.meeting.helper, receiver: @review.meeting.helpee, status: "auto", description: "meeting_finished")
      @review.meeting.update(status: "finished")
      @review.meeting.helper.profile.increment!(:total_time_credit, by = @review.meeting.duration)
      @review.meeting.helpee.profile.decrement!(:total_time_credit, by = @review.meeting.duration)
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_rating, :user_comment, :competency_rating, :competency_comment, :meeting_id)
  end

end
