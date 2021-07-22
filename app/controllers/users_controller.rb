class UsersController < ApplicationController
  def show
    @user=current_user
  end

  def edit
    @user=current_user
  end

  def update
    @user=current_user
    if @user.update(user_params)
      redirect_to my_page_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :self_introduction, :profile_image_id)
  end
end
