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

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end


end
