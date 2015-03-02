class UserPageFilesController < CourseBaseController

  skip_before_filter :verify_authenticity_token

  before_filter :set_cache_buster


  layout false

  before_filter :get_page
  skip_before_filter :validate_course_access
  
  def show
    @username = params[:username].to_s

    if @username == "base"
      @file = @page.page_files.where(name: params[:id].to_s).first
    else
      @user_page = UserPage.where(page: @page, permalink: @username).first
      @file = @user_page.page_file(params[:id].to_s)
    end

    if @file.binary?
      redirect_to @file.file(:original)
    elsif @page.editor?
      render text: @file.body_html_resolved, content_type: Mime::Type.lookup_by_extension(@file.resolved_extension)
    else
      render action: "show", layout: "minimal"

    end
  end

   protected

  def get_page
    @course_session = CourseSession.for_user(current_user,params[:session_id])
    @lesson = @course_session.lesson(params[:lesson_id])
    @page = @lesson.page(params[:page_id])
  end
end
