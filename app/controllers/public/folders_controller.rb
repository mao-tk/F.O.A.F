class Public::FoldersController < ApplicationController
  before_action :authenticate_user!

  def create
    @folder = current_user.folders.new(folder_params)
    @folder.save!
    redirect_to user_path(current_user)
  end

  def index
  end

  def show
    folder = Folder.find(params[:id])
    user = User.find(folder.user.id)
    @posts = user.posts
    bookmarks = Bookmark.where(user_id: user.id, folder_id: folder.id).pluck(:post_id)
    @bookmark_list = Post.find(bookmarks)
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end
