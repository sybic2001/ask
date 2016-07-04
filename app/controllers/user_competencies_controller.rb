class UserCompetenciesController < ApplicationController
  def create
    @user_competency = UserCompetency.new(user_competency_params)
    @user_competency.user = current_user
    if @user_competency.save
      respond_to do |format|
        format.html { redirect_to profile_path(@user) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      p @user_competency.errors
      p @user_competency.errors.full_messages
      respond_to do |format|
        format.html { render 'profiles/show_private' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @user_competency = UserCompetency.find(params[:id])
    @user_competency.destroy
  end

  private

  def user_competency_params
    params.require(:user_competency).permit(:level, :competency_id, :description)
  end
end
