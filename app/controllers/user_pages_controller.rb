class UserPagesController < CourseBaseController

  before_filter :get_models

  def update
    # create a user page if necessary
    # save all the files submitted
    # return the urls of the files

    @user_page = UserPage.fetch(@page,current_user)

    @user_page.update_attributes(page_params)

    render nothing: true
  end

  def page_params
    params.require(:page).permit(page_files_attributes: [ :id, :body ])
  end


  protected


  def get_models
    @lesson = @course_session.lesson(params[:lesson_id].to_s)
    @page = @lesson.page(params[:page_id].to_s)
  end
end
