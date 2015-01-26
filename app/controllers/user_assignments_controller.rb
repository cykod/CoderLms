class UserAssignmentsController < ApplicationController

  def create
    @lesson_assignment = LessonAssignment.where(id: params[:user_assignment][:lesson_assignment_id].to_i).first
    @user_assignment = @lesson_assignment.for_user(current_user)

    @user_assignment.update_attributes(lesson_assignment_params)

    render 'show'
  end

  def update
    @user_assignment = current_user.user_assignments.find(params[:id].to_i)
    @lesson_assignment = @user_assignment.lesson_assignment

    @user_assignment.update_attributes(lesson_assignment_params)
  
    render 'show'
  end

  def lesson_assignment_params 
    params.require(:user_assignment).permit(:url,:file)

  end
  
end
