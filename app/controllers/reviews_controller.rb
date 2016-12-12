class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @meeting = Meeting.find(params[:meeting_id])
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      Message.create(meeting: @review.meeting, sender: @review.meeting.helper, receiver: @review.meeting.helpee, status: "auto", description: "Merci pour votre évaluation. Les heures sont maintenant créditées sur vos comptes.")
      @review.meeting.update(status: "finished")
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_rating, :user_comment, :competency_rating, :competency_comment, :meeting_id)
  end

end
