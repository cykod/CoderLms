class PageFilesController < CourseBaseController

  before_filter :validate_admin
  before_filter :get_all

  before_filter :get_file, only: [ :update, :destroy, :up, :down ]

  def new
    @file = @page.page_files.build
  end


  def create
    @file = @page.page_files.build(file_params)

    @edit_course = true
    
    if @file.save
      render action: "create"
    else
      render action: "new"
    end
  end

  def destroy
    @file.destroy
    # delete the file
  end

  def up
    @file.move_higher

    render action: "reorder"
  end
  
  def down
    @file.move_lower

    render action: "reorder"
  end

  protected

  def get_all
    @lesson = @course_session.lesson(params[:lesson_id])
    @page = @lesson.page(params[:page_id].to_s)
    @user_page = UserPage.fetch(@page,current_user)
  end

  def get_file
    @file = @page.page_files.find((params[:id] || params[:page_file_id]).to_s)
  end

  def file_params
    params.require(:page_file).permit(:name,:editable)
  end
  
end
