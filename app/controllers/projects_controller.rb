class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :is_admin, only: [:destroy]
  respond_to :html, :js

  def remove_resource(resource)
    set_project
    @project.resource.destroy
    redirect_to project_path(@project)
  end

  def join_project
    @project = Project.find(params[:project_id])
    @project.users << current_user
    redirect_to project_path(@project), notice: 'Welcome aboard!'
  end

  def leave_project
    @project = Project.find(params[:project_id])
    @project.users.destroy(current_user)
    redirect_to project_path(@project), notice: 'You\'ve been successfully removed from the group. We\'re sorry to see you go!'
  end

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    set_project
    @comments = @project.comments
    @comment = Comment.new
  end

  def edit
    set_project
  end

  def create
    @project = Project.new(project_params)
    @project.users << current_user
    @project.created_by = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project), notice: 'Project successfully added!' }
        format.json { render json: @project }
      else
        format.html {redirect_to project_path(@project), notice: 'There was a problem saving your project, please try again.' }
        format.json { head :no_content }
      end
    end
  end

  def update
    set_project
    @project.update_attributes!(project_params)
    redirect_to project_path(@project)
  end

  def destroy
    set_project.destroy
    redirect_to projects_path, notice: 'Project removed... We are sad to see it go!'
  end

  def upvote
    @project = Project.find(params[:project_id])
    @project.liked_by current_user
    respond_to do |format|
      format.html {redirect_to @project, notice: 'Thanks for voting!' }
      format.json {render json: @project.likes.size - @project.dislikes.size }
    end
  end

  def downvote
    @project = Project.find(params[:project_id])
    @project.downvote_from current_user
    respond_to do |format|
      format.html do
        flash[:notice] = "Thanks for voting!"
        redirect_to @project
      end
      format.json {render json: @project.likes.size - @project.dislikes.size }
    end
  end

  def tagged
    if params[:tag].present?
      @projects = Project.tagged_with(params[:tag])
    else
      @projects = Project.all
    end
  end

  private

  def is_admin
    current_user.role == "admin"
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :completion_status, :success_status, :tag_list, :avatar, :resource1, :resource2, :resource3, :resource4, :resource5, :remove_resource1, :remove_resource2, :remove_resource3, :remove_resource4, :remove_resource5)
  end
end