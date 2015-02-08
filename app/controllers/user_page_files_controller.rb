class UserPageFilesController < CourseBaseController

  layout false

  before_filter :get_page
  skip_before_filter :validate_course_access
  
  def show
    @username = params[:username].to_s

    @user_page = UserPage.where(page: @page, permalink: @username).first

    @file = @user_page.page_file(params[:id].to_s)
    
    if @page.editor?
      render text: @file.body_html_resolved, content_type: Mime::Type.lookup_by_extension(@file.resolved_extension)
    else
      render action: "show", layout: "minimal"

    end
  end

   protected

  def get_page
    @course_session = CourseSession.fetch(params[:session_id])
    @lesson = @course_session.lesson(params[:lesson_id])
    @page = @lesson.page(params[:page_id])
  end
end
