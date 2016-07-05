class FavoritesController < ApplicationController
  def create
    @user_competency = UserCompetency.find(params[:user_competency_id])
    @favorite = Favorite.new(user: current_user, user_competency: @user_competency)
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @user_competency = UserCompetency.find(params[:user_competency_id])
    @favorite.destroy
  end
end
