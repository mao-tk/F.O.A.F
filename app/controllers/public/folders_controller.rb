class Public::FoldersController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @posts = @user.posts.order('id DESC').limit(3)
    @folders = @user.folders
    @folder = current_user.folders.new(folder_params)
    if @folder.save
      redirect_to request.referer
    else
      redirect_to request.referer
      flash[:danger] = "同じ名前のフォルダーが存在します"
    end
  end

  def index
  end

  def update
    @folder = Folder.find(params[:id])
    user = User.find(@folder.user.id)
    @posts = user.posts
    bookmarks = Bookmark.where(user_id: user.id, folder_id: @folder.id).pluck(:post_id)
    @bookmark_list = Post.find(bookmarks)
    if @folder.update(folder_params)
      redirect_to request.referer
    else
      render :show
    end
  end

  def show
    @folder = Folder.find(params[:id])
    user = User.find(@folder.user.id)
    @posts = user.posts
    bookmarks = Bookmark.where(user_id: user.id, folder_id: @folder.id).pluck(:post_id)

    if current_user == @folder.user
      @bookmark_list = Post.where(id: bookmarks).page(params[:page]).per(9)
    else
      @bookmark_list = Post.where(id: bookmarks).status_public.page(params[:page]).per(9)
    end
  end

  def destroy
    folder = Folder.find(params[:id])
    folder.destroy
    redirect_to user_path(current_user)
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end
