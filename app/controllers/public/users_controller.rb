class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post = @user.posts.order('id DESC').limit(3)
  end

  def posts
    @user = User.find(params[:user_id])
    @post = @user.posts.order('id DESC')
  end

  def confirm
  end

  def quit
  end
end
