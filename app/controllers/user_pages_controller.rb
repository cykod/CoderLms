class UserPagesController < CourseBaseController

  before_filter :get_models

  def update
    # create a user page if necessary
    # save all the files submitted
    # return the urls of the files

    @user_page = UserPage.fetch(@page,current_user)

    if !@page.quiz? || !@user_page.submitted? 
      @user_page.submitted = true
      @user_page.update_attributes(page_params)
    end

    render nothing: true
  end

  def page_params
    @page_params = params.require(:page).permit(page_files_attributes: [ :id, :body ])

    if !@page_params[:page_files_attributes].is_a?(Array)
      @page_params[:page_files_attributes] = @page_params[:page_files_attributes].values
    end
    @page_params
  end


  protected


  def get_models
    @lesson = @course_session.lesson(params[:lesson_id].to_s)
    @page = @lesson.page(params[:page_id].to_s)
  end
end
