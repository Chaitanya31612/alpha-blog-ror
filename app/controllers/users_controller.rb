class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    # byebug
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end