class PartsController < ApplicationController
  before_action :set_part, only: [:edit, :update, :destroy]
  before_action :set_course, only: [:new, :edit, :create, :update, :destroy]

  def new
    @part = Part.new
    authorize @part
  end

  def create
    @part = @course.parts.new(part_params)
    authorize @part
    if @part.save!
      flash[:notice] = "Part was successfully added to  #{@course.name}"
      redirect_to edit_course_path(@course.id)
    else
      render :new
    end
  end

  def edit
    authorize @part
  end

  def update
    @part.update(part_params)
    authorize @part
    redirect_to course_path(@course)
  end

  def destroy
    authorize @part
    @part.destroy
    redirect_to course_path(@course)
  end

  private

  def part_params
    params.require(:part).permit(:description, :video, :course_id)
  end

  def set_part
    @part = Part.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

end
