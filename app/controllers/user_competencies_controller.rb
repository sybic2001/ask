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

  def edit
    @user_competency = UserCompetency.find(params[:id])
  end

  def update
    @user_competency = UserCompetency.find(params[:id])
    if @user_competency.update(user_competency_params)
      respond_to do |format|
        format.html { redirect_to profile_path(@user) }
        format.js  # <-- will render `app/views/reviews/update.js.erb`
      end
    end
  end

  private

  def user_competency_params
    params.require(:user_competency).permit(:level, :competency_id, :description)
  end
end
