class MilestonesController < ApplicationController
  before_action :set_milestone, only: %i[show edit update destroy status]
  before_action :set_project, only: %i[create edit destroy]

  def show
    @milestones = Milestone.where(project_id: @project)
  end

  def new
    @milestone = Milestone.new
  end

  def create
    @milestone = Milestone.new(milestone_params)
    @milestone.project = @project
    authorize @milestone
    if @milestone.save
      create_logic if params[:tab] == "milestone"
    else
      render :new
    end
  end

  def edit
    authorize @milestone
  end

  def update
    authorize @milestone
    if @milestone.update(milestone_params)
      update_logic if params[:tab] == "milestone"
    else
      render :edit
    end
  end

  def destroy
    @milestone.destroy
    authorize @milestone
    redirect_to @project
  end

  def status
    authorize @milestone
    @milestone.completed = true
    @project = @milestone.project
    status_save if @milestone.save
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_milestone
    @milestone = Milestone.find(params[:id])
  end

  def milestone_params
    params.require(:milestone).permit(:title, :description, :completed, :project_id)
  end

  def create_logic
    redirect_to project_path(@project, tab: :milestone, anchor: "milestone-#{@milestone.id}")
    flash[:notice] = " Milestone was created"
  end

  def update_logic
    redirect_to project_path(@project, tab: :milestone)
    flash[:notice] = "Milestone was edited"
  end

  def status_save
    redirect_to project_path(@project, tab: :milestone, anchor: "milestone-#{@milestone.id}")
    flash[:notice] = "Milestone was marked as completed"
  end
end
