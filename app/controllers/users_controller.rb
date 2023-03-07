class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your account has been updated successfully!'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    # byebug
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @articles = @user.articles
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end