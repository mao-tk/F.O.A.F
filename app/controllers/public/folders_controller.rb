class Public::FoldersController < ApplicationController
  def create
    @folder = current_user.folders.new(folder_params)
    @folder.save!
    redirect_to user_path(current_user)
  end

  def index
  end

  def show
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end
