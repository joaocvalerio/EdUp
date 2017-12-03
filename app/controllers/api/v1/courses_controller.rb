class Api::V1::CoursesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_course, only: [ :update, :show, :destroy ]

  def index
    @courses = policy_scope(Course).order(created_at: :desc)
  end

  def company_users_index # List of users that can be assigned to courses as students
    @course = Course.first # Workaround for pundit. Need a @course to authorize the method
    company = current_user.company
    @company_users = company.users
    authorize @course
  end

  def create
    @course = Course.new(course_params)
    @course.publisher = current_user
    @course.company = current_user.company
    authorize @course
    if @course.save
      render :show, status: :created
    else
      render_error
    end
  end

  def show
  end

  def update
    students = params[:course][:students]
    assign_students_to_course(students)
    # parts = params[:course][:parts]
    # assign_parts_to_course(parts)
    if @course.update(course_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @course.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:id])
    authorize @course
  end

  def course_params
    params.require(:course).permit(:name, :description, :company_id, students: [])
  end

  def render_error
    render json: { errors: @course.errors.full_messages },
      status: :unprocessable_entity
  end

  def assign_students_to_course(students)
    if students.present?
      @course.students.clear
      students.each do |student|
        student_email = student[:email]
        if User.exists?(email: student_email)
          student = User.where(email: student_email )
          @course.students << student
        end
      end
    end
  end

end









