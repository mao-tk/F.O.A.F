class Public::UsersController < ApplicationController
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
  end

end
