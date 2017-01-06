class UserCompetenciesController < ApplicationController

  def index
    @peer_competencies = current_user.peer_competencies.where.not(user: current_user).order(:competency_id, level: :desc)
    @competencies = Competency.all
  end

  def show
    @user_competency = UserCompetency.find(params[:id])
  end

  def new
    @user_competency = UserCompetency.new()
    @experience = Experience.new()
  end

  def create
    @user_competency = UserCompetency.new(user_competency_params)
    @user_competency.user = current_user
    @experience = Experience.new()
    if @user_competency.save
      respond_to do |format|
        format.html { redirect_to profile_path(@user) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'profiles/show' }
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
    @experience = Experience.new()
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

  def search
    # @cities = params[:filters][:cities].reject(&:empty?)
    @competency_id = params[:filters][:competency_id]
    @communities = params[:filters][:communities].reject(&:empty?)
    @cities = params[:filters][:cities].reject(&:empty?)
    @levelmin = params[:filters][:level].to_i
    @peer_competencies = UserCompetency.where(user: current_user.peers).uniq
    @peer_competencies = current_user.favorite_user_competencies if params[:filters][:favorite] == "true"
    if params[:filters][:promo] == "true"
      @promo_peers = []
      current_user.memberships.where(status: "member").where.not(promotion: nil).each do |m|
        @promo_peers << current_user.promo_peers(m.community_id)
      end
      @peer_competencies = @peer_competencies.where(user: @promo_peers)
    end
    if !@competency_id.empty?
      @peer_competencies = @peer_competencies.where(competency_id: @competency_id)
      sql_seq = []
      params[:user_competency][:competency_ids].reject(&:empty?).each do |badge_id|
        sql_seq << "EXISTS (SELECT 1 FROM badges WHERE badges.competency_id = #{badge_id.to_i} AND badges.user_competency_id = user_competencies.id)"
      end
      @peer_competencies = @peer_competencies.where(sql_seq.join(" AND ")) unless sql_seq.empty?
    end
    @peer_competencies = @peer_competencies.joins(user: :memberships).where(memberships: { community_id: @communities} ) unless @communities.empty?
    @peer_competencies = @peer_competencies.where('level >= ?', @levelmin) unless @levelmin.nil?
    @peer_competencies = @peer_competencies.includes(user: :profile).where(profiles: { city: @cities }) unless @cities.empty?
    @peer_competencies = @peer_competencies.order(:competency_id, level: :desc)
  end

  private

  def user_competency_params
    params.require(:user_competency).permit(:level, :competency_id, :description, competency_ids: [])
  end
end
