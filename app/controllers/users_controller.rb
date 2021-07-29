class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @contents_quantity=current_user.contents.count
    @follow_quantity=current_user.followings.count
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
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

  def adminwithdraw
    @user.update(is_active: false)
    reset_session
    flash[:notice]="会員のアカウントを削除しました"
    redirect_to admin_users_path
  end

  def followings
    @followings = current_user.followings
  end

  def contents
    @user=User.find(params[:id])
    @contents=@user.contents
  end

  def likes
    @likes=current_user.likes
  end


  private
  def user_params
    params.require(:user).permit(:name, :self_introduction, :profile_image)
  end
end
