class CommentsController < ApplicationController
  respond_to :html, :js

  def index
    @project = Project.find(params[:project_id])
    @comments = @project.comments
  end

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to project_path(@project), notice: 'Comment created successfully'
    else
      redirect_to project_path(@project), notice: 'There was an issue adding your comment. Edit, and try again.'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    Comment.find(params[:id]).destroy
    redirect_to project_path(@project), notice: "Menu item was successfully destroyed"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end