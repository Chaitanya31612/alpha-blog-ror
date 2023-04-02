class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user #, except: [:index, :show]
  before_action :require_same_user, only: [:destroy]
  before_action :require_same_or_admin_user, only: [:edit, :update]

  def index
    @articles = Article.where(user_id: current_user.followings + [current_user]).paginate(page: params[:page], per_page: 5)
    @total_articles = Article.where(user_id: current_user.followings + [current_user]).count

    # @articles = Article.paginate(page: params[:page], per_page: 5)
    # @total_articles = Article.count
    # @featured = Article.where(featured: true)
  end

  def show
    # byebug
    @id_param = params[:id]
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    # puts 'create called'
    # render html: params[:article]

    # this is strong param passing
    @article = Article.new(article_params)
    @article.user = current_user
    # render plain: @article
    if @article.save
      flash[:notice] = 'Article was saved successfully'
      redirect_to @article
    else
      # flash[:notice] = 'Error saving the article, Try again'
      render 'new'
    end
    # way 1
    # redirect_to article_path(@article) # this will take the id and redirect to corresponding article show page
    # way 2
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article Updated Successfully"
      redirect_to @article
    else
      # flash[:notice] = "Error Updating Article"
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def upvote
    article = Article.find(params[:id])
    if article
      article.upvote
      article.save
      redirect_back fallback_location: articles_path
    else
      redirect_back fallback_location: articles_path
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :featured, category_ids: [])
  end

  def require_same_user
    unless @article.user == current_user
      flash[:alert_fail] = 'You are not allowed to perform this action!'
      redirect_to @article
    end
    end

  def require_same_or_admin_user
    unless @article.user == current_user || current_user.admin?
      flash[:alert_fail] = 'You are not allowed to perform this action!'
      redirect_to @article
    end
  end


end
