require 'rails_helper'
require 'users_helper'

RSpec.describe SessionsController, type: :request do
  context '/GET requests' do
    context '/GET new routes' do
      it 'should get #new' do
        get login_path
        expect(response).to be_successful
      end
    end
  end

  context '/POST requests' do
    it 'should not create new article (not signed in)' do
      expect{post articles_path, params: {article: {title: "new article", description: "new article description"}}}.to change(Article, :count).by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
    end

    it 'should create new article (signed in)' do
      sign_in
      expect{post articles_path, params: {article: {title: "new article", description: "new article description", user: current_user}}}.to change(Article, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(article_path(Article.last))
      follow_redirect!
      expect(response).to be_successful
    end
  end

  context '/DELETE requests' do
    it 'should logout' do
      sign_in
      delete logout_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response).to be_successful
    end
  end
end