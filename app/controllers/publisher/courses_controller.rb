class Publisher::CoursesController < ApplicationController

  def index
    @publisher_courses = current_user.published_courses
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.published_courses.build(course_params)
    if @course.save
      redirect_to publisher_courses_path
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :company_id)
  end
end
