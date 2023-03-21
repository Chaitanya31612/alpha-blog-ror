require 'rails_helper'
require 'users_helper'

RSpec.describe ApplicationController, type: :request do
  context 'home page /get requests' do
    it 'get home page (non-signed in)' do
      get root_path
      expect(response).to be_successful
    end

    it 'get articles page (signed in users)' do
      sign_in(admin=false)
      get root_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(articles_path)
      follow_redirect!
      expect(response).to be_successful
    end

    it 'get articles page (admin users)' do
      sign_in(admin=true)
      get root_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(articles_path)
      follow_redirect!
      expect(response).to be_successful
    end
  end
end