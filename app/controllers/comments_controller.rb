class CommentsController < ApplicationController
  def create
    content = Content.find(params[:content_id])
    comment = current_user.comments.new(comment_params)
    comment.content_id = content.id
    if comment.save
      redirect_to content_path(content)
    else
      @content = Content.find(params[:content_id])
      @comment = Comment.new
      @content_tags = @content.categories
      @user = @content.user
      render 'contents/show'
    end
  end

  def destroy
    Comment.find_by(id:params[:id], content_id: params[:content_id]).destroy
    redirect_to content_path(params[:content_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
