require 'set'
class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :update, :show, :destroy]

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

    assign_students_to_course(students)

    if @course.save
      redirect_to authenticated_root_path
    else
      render :new
    end
    authorize @course
  end

  def edit
    @student_ids = @course.students
    authorize @course
  end

  def update
    @course.update(course_params)
    students = params[:course][:student_ids]
    assign_students_to_course(students)
    redirect_to course_path
    authorize @course
  end

  def show
    authorize @course
  end

  def destroy
    @course.destroy
    authorize @course
    redirect_to authenticated_root_path
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :company_id, student_ids: [] )
  end

  def assign_students_to_course(students)
    if students.present?
      students.each do |student_id|
       @course.students.to_set << User.find(student_id)
      end
    end
  end
end

