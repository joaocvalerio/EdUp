class Api::V1::StudentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_course, only: [:add_students, :remove_student]


  def add_students
    byebug
    students_email = params[:students][:emails]
    assign_students_to_course(students_email)

    if @course.save
      render 'added_students.json.jbuilder'
    else
      render_error
    end
  end

  def remove_student
    @course.students.delete(User.find(params[:id]))
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
    authorize @course
  end

  def course_params
    params.require(:students).permit(students: [:emails])
  end

  def assign_students_to_course(students_email)
    students_email.each do |student_email|
    if User.exists?(email: student_email[:email])
      @student = User.where(email: student_email[:email] )
      @course.students << @student
    else
      render plain: "#{student_email} not found", status: 404
    end
  end
  end

end
