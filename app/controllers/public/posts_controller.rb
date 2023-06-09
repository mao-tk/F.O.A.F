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
    @posts = Post.order('id DESC')
    # @tag_list = Tag.all
  end

  def show
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :status)
  end
end
