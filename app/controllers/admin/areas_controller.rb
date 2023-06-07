class Admin::AreasController < ApplicationController
  def index
  end

  def edit
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end

end
