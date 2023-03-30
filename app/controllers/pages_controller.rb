class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_in?
  end

  def about
  end

  def search
    if params[:search_term].blank?
      redirect_back fallback_location: articles_path
    else
      search_term = params[:search_term].downcase
      puts "searchh #{search_term}"
      @users_results = User.where("lower(username) like :search or lower(email) like :search", search: "%#{search_term}%").limit(3)
      @articles_results = Article.where("lower(title) like ?", "%#{search_term}%").limit(3)
      @categories_results = Category.where("lower(name) like ?", "%#{search_term}%").limit(3)

      # render template: 'articles/index', locals: { users_results: @users_results, articles_results: @articles_results, categories_results: @categories_results, searched: true}
    end
  end

  # def contact
  #   puts 'hello'
  # end
end
