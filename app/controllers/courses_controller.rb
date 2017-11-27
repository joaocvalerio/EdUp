require 'set'
class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :update, :show, :destroy]
  before_action :set_part, only: [:create, :show, :edit]

  def index
    @courses = policy_scope(Course).order(created_at: :desc)
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = current_user.created_courses.build(course_params)

    authorize @course

    if @course.save!
      redirect_to edit_course_path(@course)
      flash[:notice] = "Course created!"
    else
      render :new
    end
  end

  def edit
    @student_ids = @course.students
    authorize @course
  end

  def update
    @course.update(course_params)
    authorize @course
    students = params[:course][:student_ids]
    assign_students_to_course(students)
    redirect_to course_path
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

  def set_part
    @part = Part.new
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

