class UserCompetenciesController < ApplicationController

  def index
    @peer_competencies = current_user.peer_competencies.where.not(user: current_user).order(:competency_id, level: :desc)
    @competencies = Competency.all
  end

  def show
    @user_competency = UserCompetency.find(params[:id])
  end

  def search
    # @cities = params[:filters][:cities].reject(&:empty?)
    @competency_id = params[:filters][:competency_id]
    @communities = params[:filters][:communities].reject(&:empty?)
    @levelmin = params[:filters][:level].to_i
    @peer_competencies = current_user.peer_competencies.where.not(user: current_user)
    @peer_competencies = @peer_competencies.where(competency_id: @competency_id) unless @competency_id.empty?
    @peer_competencies = @peer_competencies.joins(user: :memberships).where(memberships: { community_id: @communities} ) unless @communities.empty?
    @peer_competencies = @peer_competencies.where('level >= ?', @levelmin) unless @levelmin.nil?
    @peer_competencies = @peer_competencies.order(:competency_id, level: :desc)
  end

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
