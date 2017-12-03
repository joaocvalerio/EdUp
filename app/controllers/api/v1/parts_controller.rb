class Api::V1::PartsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_course, only: [:create]
  before_action :set_part, only: [:show, :update, :destroy]

  def create
    @part = Part.new(part_params)
    @course.parts << @part
    authorize @part
    if @part.save
      render :show, status: :created
    else
      render_error
    end
  end

  def show
  end

  def update
    if @part.update(part_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @part.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_part
    @part = Part.find(params[:id])
    authorize @part
  end


  def part_params
    params.require(:part).permit(:description, :video)
  end

end
