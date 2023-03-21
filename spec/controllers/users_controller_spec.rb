require 'rails_helper'
require 'users_helper'

RSpec.describe UsersController, type: :request do
  context '/GET requests' do
      context '/GET index route' do
        it 'should get #index' do
          get users_path
          expect(response).to be_successful
          expect(response).to have_http_status(:success)
        end

        it 'should get #index (admin user)' do
          sign_in(admin=true)
          get users_path
          expect(response).to be_successful
          expect(response).to have_http_status(:success)
        end
      end

    context '/GET new routes' do
      it 'should get #new (admin)' do
        sign_in(admin=true)
        get signup_path
        expect(response).to be_successful
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Sign Up")
      end

      it 'should get #new (non admin)' do
        sign_in
        get signup_path
        expect(response).to be_successful
      end

      it 'should get #new (not signed in)' do
        get signup_path
        expect(response).to be_successful
      end
    end

    context '/GET show routes' do
      let(:user) {User.create(username: 'Test user', email: 'test@test.com', password: '12rfdsfs')}

      it 'should get #show for user id' do
        get user_path(user)
        expect(response).to be_successful
        expect(response.body).to include(user.username)
      end

      it 'should get #show for user id (non-admin)' do
        sign_in
        get user_path(user)
        expect(response).to be_successful
        expect(response.body).to include(user.username)
      end

      it 'should get #show for user id (admin user)' do
        sign_in(admin=true)
        get user_path(user)
        expect(response).to be_successful
        expect(response.body).to include(user.username)
      end
    end

    context '/GET edit routes' do
      let(:user) {User.create(username: 'Test user', email: 'test@test.com', password: '12rfdsfs')}

      it 'should not get #edit for user id (non-signed-in users)' do
        get edit_user_path(user)
        expect(response).to_not be_successful
      end

      context '/GET edit for signed in user' do
        it 'should not get #edit for user id (different profile)' do
          sign_in
          get edit_user_path(user)
          expect(response).to_not be_successful
        end

        it 'should get #edit for user id (admin users)' do
          sign_in(admin=true)
          get edit_user_path(user)
          expect(response).to be_successful
        end

        it 'should get #edit for user id (same profile)' do
          sign_in
          get edit_user_path(current_user)
          expect(response).to be_successful
        end
      end
    end
  end

  context '/POST requests' do
    it 'create new user' do
      expect{post users_path, params: {user: {username: "new user", email: "newuser@examp.com", password: "kjflsdkjf"}}}.to change(User, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_path(current_user))
      follow_redirect!
      expect(response).to be_successful
      expect(response.body).to include(current_user.username)
    end
  end

  context '/PATCH or /PUT request' do
    let!(:user) {User.create(username: 'Test user', email: 'test@test.com', password: '12rfdsfs')}

    it 'should not update profile (non signed in)' do
      patch user_path(user), params: {user: { username: 'Edit user' }}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
      # follow_redirect!
    end

    it 'should update profile (admin)' do
      sign_in(admin=true)
      patch user_path(user), params: {user: { username: 'Edit user' }}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_path(user))
      follow_redirect!
      expect(response).to be_successful
      expect(response.body).to include('Edit user')
    end

    context '/PATCH edit route for signed in users' do
      it 'should not update profile (different profile)' do
        sign_in
        patch user_path(user), params: {user: { username: 'Edit user' }}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_path(user))
        # follow_redirect!
      end

      it 'should update profile (same profile)' do
        sign_in
        patch user_path(current_user), params: {user: { username: 'Edit user' }}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_path(current_user))
        follow_redirect!
        expect(response).to be_successful
        expect(response.body).to include('Edit user')
      end
    end
  end

  context '/DELETE requests' do
    let!(:user) {User.create(username: 'Test user', email: 'test@test.com', password: '12rfdsfs')}

    it 'should not delete user (not signed in)' do
      expect{delete user_path(user)}.to change(User, :count).by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
      # follow_redirect!
    end

    it 'should not delete user (different user)' do
      sign_in
      expect{delete user_path(user)}.to change(User, :count).by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_path(user))
      # follow_redirect!
    end

    it 'should delete user (admin)' do
      sign_in(admin=true)
      expect{delete user_path(user)}.to change(User, :count).by(-1)
      expect(response).to redirect_to(articles_path)
      follow_redirect!
      expect(response).to be_successful
    end

    it 'should delete user (same user)' do
      sign_in
      expect{delete user_path(current_user)}.to change(User, :count).by(-1)
      expect(response).to redirect_to(articles_path)
      follow_redirect!
      expect(response).to be_successful
      # expect(before_count - User.count).to eq(1)
    end
  end
end