class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(",")
    if @post.save!
      @post.save_tag(tag_list)
      redirect_to post_path(@post)
    else
      render :new
    end
  end

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
    @folders = current_user.folders
    # @folder = Folder.find(params[:id])
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comment = Comment.new
    @bookmarked_folders = current_user.bookmarks.where(post: @post)

    if @post.status_private? && @post.user != current_user
      redirect_to root_path
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :status)
  end
end
