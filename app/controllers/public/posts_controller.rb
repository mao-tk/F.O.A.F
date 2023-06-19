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
      if params[:search].start_with?("#")
        # タグ検索の場合
        tag_name = params[:search].slice(1..-1)
        @tag = Tag.find_by(name: tag_name)
        @posts = @tag.posts.status_public.order('id DESC').page(params[:page]).per(9) if @tag
      else
        # キーワード検索の場合
        @keyword = params[:search]
        @posts_all = Post.search(@keyword)
        @posts = @posts_all.status_public.order('id DESC').page(params[:page]).per(9)
      end
    elsif params[:tag_id]
      @tag_list = Tag.all
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.status_public.order('id DESC').page(params[:page]).per(9)
    else
      @posts = Post.status_public.includes(:user).order('id DESC').page(params[:page]).per(9)
    end
  end

  # def search
  #   if (params[:keyword])[0] == '#'
  #     @posts = Tag.search(params[:keyword]).order('created_at DESC')
  #   else
  #     @posts = Post.search(params[:keyword]).order('created_at DESC')
  #   end
  # end

  def show
    @folders = current_user.folders
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
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_tag(tag_list)
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
