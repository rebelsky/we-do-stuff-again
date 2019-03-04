class UsersController < ApplicationController

  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def edit_email
    @user = User.find(params[:user_id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update_email
    @user = User.find(params[:user_id])
    if @user.update_attributes(user_params)
      flash[:success] = "User email updated"
      redirect_to users_url
    else
      render 'update_email'
    end
  end  
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User password updated"
      redirect_to users_url
    else
      render 'edit'
    end
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  private

    def user_params
      params.require(:user).permit(:id, :name, :email, :password,
                                   :password_confirmation)
    end
  
end

