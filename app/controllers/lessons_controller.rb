class LessonsController < CourseBaseController

  before_filter :validate_admin, except: :show

  def new
    @lesson = @course.lessons.build

  end

  def create
    @lesson = @course.lessons.build(lesson_params)

    if @lesson.save
      redirect_to session_path(@course_session.permalink)
    end

  end


  def show
    @lesson = @course_session.lesson(params[:id].to_s)
    redirect_to session_lesson_page_path(@course_session,@lesson.position,1)
  end

  def edit
    @lesson = @course_session.lesson(params[:id].to_s)

    render action: "new"
  end

  def update
    @lesson = @course_session.lesson(params[:id].to_s)

    @lesson.update_attributes(lesson_params);
    redirect_to session_path(@course_session)
  end

  def destroy

  end

  protected



  def lesson_params
    params.require(:lesson).permit(:name, :permalink, :visible_starting, :due_date, :body)
  end
end
