class CoursesController < ApplicationController

  def index
    @courses = policy_scope(Course).order(created_at: :desc)
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = current_user.published_courses.build(course_params)
    students = params[:course][:student_ids]

    # publisher can create a course without students
    if students.present?
      students.each do |student_id|
        @course.students << User.find(student_id)
      end
    end

    if @course.save
      redirect_to authenticated_root_path
    else
      render :new
    end
    authorize @course
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :company_id)
  end
end



