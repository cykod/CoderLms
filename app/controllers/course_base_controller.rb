class CourseBaseController < ApplicationController

  before_filter :validate_course_access

  def validate_course_access
    return redirect_to root_path unless current_user

    @course_session = CourseSession.for_user(current_user,(params[:session_id] || params[:id]).to_s)
    if @course_session
      @course = @course_session.course
    else
      redirect_to root_path
    end
  end

  def validate_admin
    unless @course_session.admin?
      redirect_to session_path(@course_session)
    end
  end

  helper_method :admin?
  def admin?
    @course_session.admin?
  end


end
