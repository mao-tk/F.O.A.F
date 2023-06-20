class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('id DESC').limit(3)

    @folder = Folder.new
    @folders = @user.folders
  end

  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts.order('id DESC')
  end

  def confirm
  end

  def quit
    user = current_user
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会手続きが完了しました"
  end

end
