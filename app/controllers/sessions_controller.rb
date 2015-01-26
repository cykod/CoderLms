class SessionsController < CourseBaseController

  skip_before_filter :validate_course_access, only: [ :create ]

  def show
  end


  def create
    course_session = CourseSession.where(code: code, open: true).first
    if course_session
      if current_user.course_sessions.where(id: course_session.id).first
        return redirect_to session_path(course_session)
      else
        course_session.user_course_sessions.create(user: current_user)
        return redirect_to session_path(course_session)
      end
    end

    flash[:notice] = "Invalid Course Code - please try again"
    redirect_to root_path
  end

  protected

  def code
    params[:user_course_session][:code].to_s
  end
end
