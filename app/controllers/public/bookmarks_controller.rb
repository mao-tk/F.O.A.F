class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @folder = Folder.find(params[:folder_id])
    @post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.new(post_id: @post.id, folder_id: @folder.id)
    bookmark.save
    @bookmarked_folders = current_user.bookmarks.where(post: @post)
    @folders = current_user.folders
  end


  def destroy
    @folder = Folder.find(params[:folder_id])
    @post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post_id: @post.id, folder_id: @folder.id)
    bookmark.destroy
    @bookmarked_folders = current_user.bookmarks.where(post: @post)
    @folders = current_user.folders
  end
end
