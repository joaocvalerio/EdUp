module ApplicationHelper

  def state(course, student)
    CoursesUser.where(user_id: student.id, course_id: course.id).first.state
  end

end
