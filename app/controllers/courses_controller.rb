class CoursesController < ApplicationController

  def index
    @courses = policy_scope(Course).order(created_at: :desc)
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.published_courses.build(course_params)

    params[:course][:student_ids].each do |student_id|
      @course.students << User.find(student_id)
    end

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



