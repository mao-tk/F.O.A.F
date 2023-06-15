class Public::PostsController < ApplicationController
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
      @posts = @posts_all.page(params[:page]).per(9)
    else
      @posts = Post.order('id DESC').page(params[:page]).per(9)
    end

  end

  def show
    @folders = current_user.folders
    @folder = Folder.find(params[:id])
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comment = Comment.new
    @bookmarked_folders = current_user.bookmarks.pluck(:folder_id)
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :status)
  end
end
