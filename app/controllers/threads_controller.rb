class ThreadsController < CourseBaseController

  def create
    lesson = @course_session.lessons.find(lesson_id)

    lesson.add_thread(@course_session,current_user,post_params)

  end

  protected

  def lesson_id
    params[:lesson_id].to_s
  end

  def post_params
    params.require[:lesson_thread].permit(:body)
  end
end
