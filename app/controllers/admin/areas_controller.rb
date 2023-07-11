class Admin::AreasController < ApplicationController
  before_action :authenticate_admin!

  def index
    @areas = Area.all
    @area = Area.new
  end


  def create
    @areas = Area.all
    @area = Area.new(area_params)
    if @area.save
      redirect_to admin_areas_path
    else
      render :index
    end
  end

  def update
    @areas = Area.all
    @area = Area.find(params[:id])
    if @area.update(area_params)
      redirect_to request.referer
    else
      render :index
    end
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end

end
