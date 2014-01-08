class CommentsController < ApplicationController
  respond_to :html, :js

  def index
    @project = Project.find(params[:project_id])
    @comments = @project.comments
  end

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    if @comment.save
      redirect_to project_path(@project), notice: 'Comment created successfully'
    else
      flash.now[:notice] = "There was an issue adding your comment. Edit, and try again."
      render action: '../projects/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end