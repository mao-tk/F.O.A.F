class Admin::AreasController < ApplicationController
  before_action :authenticate_admin!

  def index
    @areas = Area.all
    @area = Area.new
  end

  def edit
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to admin_areas_path
    else
      render :index
    end
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end

end
