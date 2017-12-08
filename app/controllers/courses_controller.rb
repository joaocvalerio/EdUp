require 'set'
class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :update, :show, :destroy]
  before_action :set_part, only: [:show, :edit]

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
    students_ids = params[:course][:student_ids]
    assign_students_to_course(students_ids)
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

  def course_students
    @course = Course.find(params[:course_id])
    @students = @course.students
    authorize @course
  end

  def track_clicks
    student = User.where(email: params[:user_email]).first
    @course = Course.find(params[:course])
    courses_users = CoursesUser.where(user_id: student.id, course_id: @course.id).first
    courses_users.update(state: "clicked")
    redirect_to course_path(@course)
    authorize @course
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

  def assign_students_to_course(students_ids)
    if students_ids.present?
      students_ids.each do |student_id|
        student = User.find(student_id)
        if @course.students.to_set << student # this way there is no validation error if user already belongs to course (user has been already taken)
          UserMailer.invite(student, @course).deliver_now
        end
      end
    end
  end

end

