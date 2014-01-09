class ProjectmembersController < ApplicationController
  def index
    @projectmembers = Projectmember.all
  end

  def new
    @user = current_user
    @project = Project.find(params[:id])
    @projectmember = Projectmember.new(user_id: @user.id, project_id: @project.id)
  end
end