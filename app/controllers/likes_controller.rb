class LikesController < ApplicationController

  def show
    @likes=current_user.likes
  end

  def create
    content=Content.find(params[:content_id])
    like=current_user.likes.new(content_id:content.id)
    like.save
    redirect_to content_path(content)
  end

  def destroy
    content=Content.find(params[:content_id])
    like=current_user.likes.find_by(content_id:content.id)
    like.destroy
    redirect_to content_path(content)
  end
end
