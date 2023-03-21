require 'rails_helper'
require 'users_helper'
require 'article_helper'


RSpec.describe ArticlesController, type: :request do

  let!(:article) do
    user = User.create(username: "user", email: "user@test.com", password: "123456")
    Article.create(title: "new article", description: "new article description", user: user)
  end
  context '/GET requests' do
    context '/GET #index route' do
      it 'should get #index' do
        get articles_path
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context '/GET #new routes' do
      it 'should get #new (admin)' do
        sign_in(admin=true)
        get new_article_path
        expect(response).to be_successful
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Create Article")
      end

      it 'should get #new (non admin)' do
        sign_in
        get new_article_path
        expect(response).to be_successful
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Create Article")
      end

      it 'should not get #new (not signed in)' do
        get new_article_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_path)
      end
    end

    context '/GET show routes' do
      # let(:article) { new_article }

      it 'should get #show for article' do
        get article_path(article)
        expect(response).to be_successful
        expect(response.body).to include(article.title)
      end

      it 'should get #show for article (non-admin)' do
        sign_in
        get article_path(article)
        expect(response).to be_successful
        expect(response.body).to include(article.title)
      end

      it 'should get #show for article (admin user)' do
        sign_in(admin=true)
        get article_path(article)
        expect(response).to be_successful
        expect(response.body).to include(article.title)
      end
    end

    context '/GET edit routes' do
      it 'should not get #edit for article (non-signed-in users)' do
        get edit_article_path(article)
        expect(response).to_not be_successful
      end

      context '/GET edit for signed in user' do
        it 'should not get #edit for article (different profile)' do
          sign_in
          get edit_article_path(article)
          expect(response).to_not be_successful
        end

        it 'should get #edit for article (admin users)' do
          sign_in(admin=true)
          get edit_article_path(article)
          expect(response).to be_successful
        end

        it 'should get #edit for article (same profile)' do
          post '/login', params: {session: { email:"user@test.com", password:"123456" }}
          get edit_article_path(article)
          expect(response).to be_successful
        end
      end
    end
  end

  context '/POST requests' do
    it 'create new article (signed in)' do
      sign_in
      expect{post articles_path, params: {article: {title: "new article", description: "this is new article description", user: current_user}}}.to change(Article, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(article_path(Article.last))
      follow_redirect!
      expect(response).to be_successful
      expect(response.body).to include(article.title)
    end

    it 'create new article (admin user)' do
      sign_in(admin=true)
      expect{post articles_path, params: {article: {title: "new article", description: "this is new article description", user: current_user}}}.to change(Article, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(article_path(Article.last))
      follow_redirect!
      expect(response).to be_successful
      expect(response.body).to include(article.title)
    end

    it 'create new article (not signed in)' do
      expect{post articles_path, params: {article: {title: "new article", description: "this is new article description"}}}.to change(Article, :count).by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
    end
  end

  context '/PATCH or /PUT request' do
    it 'should not update article (non signed in)' do
      patch article_path(article), params: {article: { title: 'Edit title' }}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
    end

    it 'should update article (admin)' do
      sign_in(admin=true)
      patch article_path(article), params: {article: { title: 'Edit title' }}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(article_path(article))
      follow_redirect!
      expect(response).to be_successful
    end

    context '/PATCH edit route for signed in users' do
      it 'should not update article (different profile)' do
        sign_in
        patch article_path(article), params: {article: { title: 'Edit title' }}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(article_path(article))
      end

      it 'should update article (same profile)' do
        post '/login', params: {session: { email:"user@test.com", password:"123456" }}
        patch article_path(article), params: {article: { title: 'Edit title' }}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(article_path(article))
        follow_redirect!
        expect(response).to be_successful
      end
    end

    context '/DELETE requests' do
      it 'should not delete article (not signed in)' do
        expect{delete article_path(article)}.to change(Article, :count).by(0)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_path)
      end

      it 'should not delete article (different user)' do
        sign_in
        expect{delete article_path(article)}.to change(Article, :count).by(0)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(article_path(article))
      end

      it 'should delete user (admin)' do
        sign_in(admin=true)
        expect{delete article_path(article)}.to change(Article, :count).by(-1)
        expect(response).to redirect_to(articles_path)
        follow_redirect!
        expect(response).to be_successful
      end

      it 'should delete user (same user)' do
        post '/login', params: {session: { email:"user@test.com", password:"123456" }}
        expect{delete article_path(article)}.to change(Article, :count).by(-1)
        expect(response).to redirect_to(articles_path)
        follow_redirect!
        expect(response).to be_successful
      end
    end
  end
end