class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update!(comment_params)
      render json: @comment
    else
      head :bad_request
    end

  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end



end
