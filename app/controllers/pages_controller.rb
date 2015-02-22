class PagesController < CourseBaseController

  before_filter :validate_admin, except: :show

  before_filter :get_lesson

  def show
    @page = @lesson.page(params[:id].to_s)

    #@page = @lesson.add_page! if !@page && admin?

    @user_page = UserPage.fetch(@page,current_user)

    @edit_course = admin? && (params[:editor].present? || @page.page_files.length == 0)

    render action: "show", layout: "lesson"
  end

  def new
    @page = Page.new
  end

  def create
    @page = @lesson.add_page!(new_page_params) if !@page && admin?
    render action: 'new' unless @page.valid? 
  end

  def update
    @page = @lesson.page(params[:id].to_s)

    @page.update_attributes(page_params)

    render nothing: true
  end



  protected

  def get_lesson
    @lesson = @course_session.lesson(params[:lesson_id])
  end

  def new_page_params
    params.require(:page).permit(:name, :page_type)
  end

  def page_params
    params.require(:page).permit(:name, :page_type, :quiz_state, page_files_attributes: [ :id, :body ])
  end
end
