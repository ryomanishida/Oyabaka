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
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def withdraw
    current_user.update(is_active: false)
    reset_session
    flash[:notice]="退会しました。"
    redirect_to root_path
  end

  def followings
    @followings = current_user.followings
  end

  def contents
    @user=User.find(params[:id])
    @contents=@user.contents
  end


  private
  def user_params
    params.require(:user).permit(:name, :self_introduction, :profile_image)
  end
end
