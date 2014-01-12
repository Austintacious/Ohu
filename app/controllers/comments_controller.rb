class CommentsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @comments = @project.comments
  end

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    @comment.user_id = current_user.id
    @user = "#{@comment.user.first_name} #{@comment.user.last_name}"
    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_path(@project), notice: 'Comment created successfully' }
        format.json { render json: {comment: @comment, user: @user} }
      else
        format.html { redirect_to project_path(@project), notice: 'There was an issue adding your comment. Edit, and try again.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    Comment.find(params[:id]).destroy
    redirect_to project_path(@project), notice: "Your comment was successfully destroyed"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end