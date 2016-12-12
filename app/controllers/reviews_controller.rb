class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @meeting = Meeting.find(params[:meeting_id])
  end

  def create
    @review = Review.new(review_params)
    @review.save
  end

  private

  def review_params
    params.require(:review).permit(:user_rating, :user_comment, :competency_rating, :competency_comment, :meeting_id)
  end

end
