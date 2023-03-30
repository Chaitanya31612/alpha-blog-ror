class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category created successfully!'
      redirect_to @category
    else
      render 'new'
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 6)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
    @total_articles = @category.articles.count
  end

  def edit

  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category name has been updated successfully!'
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category deleted successfully!"
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_user
    unless logged_in?
      flash[:alert_fail] = 'You are not allowed to perform this action!'
      redirect_to login_path
    end
  end

  def require_admin
    unless logged_in? and current_user.admin?
      flash[:alert_fail] = 'This action can only be performed by admin'
      redirect_to categories_path
    end
  end
end