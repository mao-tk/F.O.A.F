class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(9)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts.order('id DESC').page(params[:page]).per(9)
  end

  def comments
    @user = User.find(params[:user_id])
    @comments = @user.comments.order('id DESC')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end
end
