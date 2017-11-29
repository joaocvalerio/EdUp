class Api::V1::CoursesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_course, only: [:edit, :update, :show, :destroy]

  def index
    @courses = policy_scope(Course).order(created_at: :desc)
  end

  def create
    byebug
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

  private

  def set_course
    @course = Course.find(params[:id])
    authorize @course
  end

  def course_params
    params.require(:course).permit(:name, :description, :company_id, student_ids: [] )
  end

  def render_error
    render json: { errors: @course.errors.full_messages },
      status: :unprocessable_entity
  end
end









# def create
#     @restaurant = Restaurant.new(restaurant_params)
#     @restaurant.user = current_user
#     authorize @restaurant
#     if @restaurant.save
#       render :show, status: :created
#     else
#       render_error
#     end


#  def create
#     @course = current_user.created_courses.build(course_params)

#     authorize @course

#     if @course.save!
#       redirect_to edit_course_path(@course)
#       flash[:notice] = "Course created!"
#     else
#       render :new
#     end
#   end
