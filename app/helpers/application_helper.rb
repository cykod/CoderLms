module ApplicationHelper

  def page_path(page)
    session_lesson_page_path(@course_session, @lesson.position, page)
  end

  def pages_path
    session_lesson_pages_path(@course_session, @lesson.position)
  end

  def file_path(page_file,suffix="")
    self.send("session_lesson_page_page_file#{suffix}_path",@course_session, @lesson.position, @page.position, page_file)
  end

  def files_path
    session_lesson_page_page_files_path(@course_session, @lesson.position, @page.position)
  end


  def user_page_file_path(page_file)
    session_lesson_page_user_page_file_path(@course_session, @lesson.position, @page.position, @user_page.permalink, page_file.name)
  end


  def page_save_path(page)
    if admin? 
      session_lesson_page_path(@course_session, @lesson.position, page.position) 
    else
      session_lesson_page_user_pages_path(@course_session, @lesson.position, page.position)
    end
  end
end
