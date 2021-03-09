class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy media]
  before_action :authenticate_user!

  skip_before_action :authenticate_user!, only: %i[ index tagged ]

  def show
    @user = current_user
    @collaboration = Collaboration.new
    @milestone = Milestone.new
    @milestones = Milestone.where(project_id: @project)
    @collabs = Collaboration.where(project_id: @project, status: "confirmed")
    @project_collabs = Collaboration.where(project_id: @project)
    @pending_collabs = Collaboration.where(project_id: @project, status: nil)

    get_user_type

    # show related projects from tags
    @related_projects = @project.find_related_tags

    if @favourite_project = FavouriteProject.find_by(user: @user, project: @project)
      @favourite_project
    else
      @favourite_project = FavouriteProject.new
    end
    authorize @project
    # Chat Logic
    @project_chat = ProjectChat.find_by(project: params[:id])
    @project = @project_chat.project
    @message = Message.new
    authorize @project_chat

  end

  def index
    sql_query = "title ILIKE :query OR budget ILIKE :query OR location ILIKE :query"
    @user = current_user
    @favourite_project = FavouriteProject.new
    if params[:query].present?
      @projects = policy_scope(Project.search_by_title_and_budget_and_location_and_description(params[:query])) +
      policy_scope(Project.tagged_with(params[:query]))
    elsif @projects = policy_scope(Project.where(sql_query, query: "%#{params[:query]}%")).order(created_at: :desc).empty?
      redirect_to projects_path
      flash[:notice] = " No projects with #{params[:query]}"
    else
      @projects = policy_scope(Project).order(created_at: :desc)
    end
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    authorize @project
    if @project.save
      redirect_to @project
      flash[:notice] = " New project: \n #{@project.title} was created"
    else
      render :new
    end
  end

  def edit
    authorize @project
  end

  def update
    authorize @project
    if @project.update(project_params)

      # Redirects to previous page
      # redirect_to session.delete(:return_to)
      if params[:tab] == "media"
        redirect_to project_path(@project, tab: :media)
      else  
        redirect_to project_path(@project)
      end
  
      flash[:notice] = " \n #{@project.title} was edited"
    else
      render :edit
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to root_path
  end

  # ❌ not displaying tagged projects
  def tagged
    if params[:tag].present?
      @projects = Project.tagged_with(params[:tags])
      authorize @projects
    else
      @projects = policy_scope(Project).order(created_at: :desc)
    end
  end

  def media
    authorize @project
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:user_id, :title, :description, :status, :budget, :max_members, :start_date, :end_date, :tag_list, :photo, media: [] )
  end

  def get_user_type
    collaboration = Collaboration.find_by(project_id: @project.id, user_id: current_user.id)
    if @project.user_id == current_user.id
      @user_type = :owner
    elsif collaboration
      if collaboration.confirmed == true
        @user_type = :collaborator
      else
        @user_type = :pending
      end
    else
      @user_type = :visitor
    end
  end

  # ❌
  def get_favourites_for_current_user
    if Favourite.find_by(project_id: @project.id, user_id: current_user.id)
      :favourite
    end
  end

end
