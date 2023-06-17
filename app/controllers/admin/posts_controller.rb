class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:search]
      @keyword = params[:search]
      @posts_all = Post.search(@keyword)
      @posts = @posts_all.status_public.page(params[:page]).per(9)
    else
      @posts = Post.status_public.includes(:user).order('id DESC').page(params[:page]).per(9)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comment = Comment.new
  end
end
