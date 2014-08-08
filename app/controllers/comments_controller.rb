class CommentsController < ApplicationController

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      @comment = user.comments.new(comment_params)
    elsif params[:goal_id]
      goal = Goal.find(params[:goal_id])
      @comment = goal.comments.new(comment_params)
    end

    @comment.author_id = current_user.id

    if @comment.save
      if params[:user_id]
        redirect_to user_url(user)
      elsif params[:goal_id]
        redirect_to user_url(goal.user)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @parent = @comment.commentable
    @comment.destroy

    if @parent.class == User
      redirect_to user_url(@parent)
    elsif @parent.class == Goal
      redirect_to user_url(@parent.user)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
