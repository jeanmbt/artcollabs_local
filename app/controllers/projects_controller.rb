class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy media]
  before_action :set_user, only: %i[show index]
  before_action :authenticate_user!

  skip_before_action :authenticate_user!, only: %i[index tagged]

  def show
    fetch_project_data
    set_user_type
    set_user_favourites
    set_chat
    @counter = 1
    authorize @project
  end

  def index
    @favourite_project = FavouriteProject.new
    @query = (policy_scope(Project.search_by_title_budget_location_and_description(params[:query])) +
              policy_scope(Project.tagged_with(params[:query])))
    index_logic
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
      add_milestone
      redirect_to @project
      flash[:notice] = " New project: \n #{@project.title} was created."
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
      update_logic
    else
      render :edit
      flash[:notice] = " \n #{@project.title} was not edited."
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to @projects
  end

  def tagged
    if params[:tag].present?
      @projects = Project.tagged_with(params[:tag]).page params[:page]
      authorize @projects
    else
      @projects = policy_scope(Project).order(created_at: :desc).page params[:page]
    end
  end

  def media
    authorize @project
  end

  def collection
    @trending_topics = Project.where(tag_list: ["gender", "identity", "vidoe-art", "masculinity"])
    @paid_works = Project.where(budget: ["low", "medium", "high"])
    @collection = [@trending_topics, @paid_works]
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:user_id, :title, :description,
                                    :status, :budget, :max_members,
                                    :start_date, :end_date, :tag_list, :photo, media: [])
  end

  def set_user_type
    collaboration = Collaboration.find_by(project_id: @project.id, user_id: current_user.id)
    if @project.user_id == current_user.id
      @user_type = :owner
    elsif collaboration
      collab_logic(collaboration)
    else
      @user_type = :visitor
    end
  end

  def collab_logic(col)
    if col.confirmed == true
      @user_type = :collaborator
    else
      @user_type = :pending
    end
  end

  def set_user_favourites
    if @favourite_project == FavouriteProject.find_by(user: @user, project: @project)
      @favourite_project
    else
      @favourite_project = FavouriteProject.new
    end
  end

  def set_user
    @user = current_user
  end

  def fetch_project_data
    @collaboration = Collaboration.new
    @milestone = Milestone.new
    @milestones = Milestone.where(project_id: @project)
    @collabs = Collaboration.where(project_id: @project, status: "confirmed")
    @project_collabs = Collaboration.where(project_id: @project)
    @pending_collabs = Collaboration.where(project_id: @project, status: nil)
    # show related projects from tags
    @related_projects = @project.find_related_tags
  end

  def set_chat
    @project_chat = ProjectChat.find_by(project: params[:id])
    @project = @project_chat.project
    @message = Message.new
    authorize @project_chat
  end

  def index_logic
    if params[:query].present?
      @searched = params[:query]
      if @query.empty?
        redirect_to projects_path(search: :noresults, searched: @searched)
        flash[:notice] = " No projects with #{params[:query]}"
      else
        @projects = Kaminari.paginate_array(@query).page(params[:page])
      end
    else
      @projects = policy_scope(Project).order(created_at: :desc).page (params[:page])
    end
  end

  def update_logic
    if params[:tab] == "media"
      redirect_to project_path(@project, tab: :media)
    else
      redirect_to project_path(@project)
    end
    flash[:notice] = " \n #{@project.title} was edited."
  end

  def set_previous_page
    session[:return_to] ||= request.referer
  end

  def add_milestone
    @first_milestone = Milestone.new(title: "Project created", description: "The project #{@project.title} was created on #{Date.today} by #{@project.user.username}", completed: true)
    @first_milestone.project = @project
    @first_milestone.save
  end
end
