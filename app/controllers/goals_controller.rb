class GoalsController < ApplicationController
  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(current_user)
  end

  def goal_params
    params.require(:goal).permit(:body, :setting)
  end
end
