class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    # byebug
    @article = Article.find(params[:id])
    @id_param = params[:id]
  end
end
