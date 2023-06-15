class Public::BookmarksController < ApplicationController
  def create
    folder = Folder.find(params[:folder_id])
    post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.new(post_id: post.id, folder_id: folder.id)
    bookmark.save!
    redirect_to post_path(post)
  end


  def destroy
    folder = Folder.find(params[:folder_id])
    post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post_id: post.id, folder_id: folder.id)
    bookmark.destroy!
    redirect_to post_path(post)
  end
end
