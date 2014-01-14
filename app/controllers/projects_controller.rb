class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    set_project
  end

  def edit
    set_project
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to project_path(@project), notice: 'Project successfully added!'
    else
      render :new
    end
  end

  def update
    @project = Project.new(project_params)

    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    set_project.destroy
    redirect_to projects_path, notice: 'Project removed... We are sad to see it go!'
  end

  def upvote
    @project = Project.find(params[:project_id])
    @project.liked_by current_user
    redirect_to @project
  end

  def downvote
    @project = Project.find(params[:project_id])
    @project.downvote_from current_user
    redirect_to @project
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :completion_status, :success_status)
  end
end