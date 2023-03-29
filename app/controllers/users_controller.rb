class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:index, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :set_follow_user, only: [:follow, :unfollow]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    @total_articles = @user.articles.length
  end

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
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = 'Account has been deleted successfully!'
    redirect_to articles_path
  end

  def follow
    if @follow_user
      current_user.follow(@follow_user)
      redirect_back fallback_location: users_path
    else
      redirect_back fallback_location: users_path
    end
  end

  def unfollow
    if @follow_user
      current_user.unfollow(@follow_user)
      redirect_back fallback_location: users_path
    else
      redirect_back fallback_location: users_path
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_follow_user
    @follow_user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    # if current_user != @user && !current_user.admin?
    unless current_user.admin? || @user == current_user
      flash[:alert_fail] = 'You are not allowed to perform this action!'
      redirect_to @user
    end
  end
end