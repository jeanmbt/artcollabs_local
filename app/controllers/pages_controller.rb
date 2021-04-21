class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:home]

  def home
    @projects = policy_scope(Project).order(created_at: :desc)
    # Collections
    @collections = ["Group-Shows", "Dance", "Video", "Gender"]
  end

  def dashboard
    @user = current_user
    set_user_data
  end

  def profile
    @user = User.find(params[:id])
    set_user_data
  end

  private

  def set_my_collabs
    @pending_collabs = []
    @collaborations = Collaboration.where(user: @user)
    @collaborations_to_my_projects = Collaboration.where(project_id: @projects)
    @my_collabs_accepted = Collaboration.where(user: @user, confirmed: true)
    @my_collabs_pending = @collaborations - @my_collabs_accepted
    @collaborations_to_my_projects.each do |collab|
      if collab.status == nil
        @pending_collabs << collab
      end
    end
  end

  def set_projects
    @projects = Project.where(user: current_user)
  end

  def set_favourites
    @favorites = FavouriteProject.where(user: @user)
    @project_faves = @favorites.map { |fave| Project.find(fave.project_id) }
  end

  def set_user_data
    set_projects
    set_my_collabs
    set_favourites
  end
end
