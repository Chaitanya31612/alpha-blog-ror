require 'rails_helper'
require 'users_helper'

RSpec.describe CategoriesController, type: :request do

  context '/GET requests' do
    let(:category) {Category.create(name: "Sports")}
    it 'should not get #index' do
      get categories_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
    end

    it 'should not get #new (non admin)' do
      sign_in
      get new_category_path
      expect(response).not_to be_successful
    end

    it 'should not get #new (not signed in)' do
      get new_category_path
      expect(response).not_to be_successful
    end

    it 'should not get #show for category id (non-signed-in users)' do
      get category_path(category)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
    end

    it 'should not get #edit for category id (non-signed-in users)' do
      get edit_category_path(category)
      expect(response).to_not be_successful
    end

    it 'should not get #edit for category id (normal users)' do
      sign_in
      get edit_category_path(category)
      expect(response).to_not be_successful
    end

    it 'should get #edit for category id (admin users)' do
      sign_in(admin=true)
      get edit_category_path(category)
      expect(response).to be_successful
    end
  end

  #======================================================================================================#

  context '/POST requests' do
    it 'create new category (admin)' do
      sign_in(admin=true)
      before_count = Category.count
      post categories_path, params: {category: { name: 'Travel1' }}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(category_path(Category.last))
      follow_redirect!
      expect(response).to be_successful
      expect(response.body).to include('Travel')
      expect(Category.count - before_count).to eq(1)
      # expect(Category.count).change by_eq(1)
      # expect{ response }.to change {Category.count}.by 1
      # expect{response}.to change(Category, :count).by(1)
      # expect(@category).to be_valid
    end

    it 'should not create category (non-admin)' do
      sign_in
      before_count = Category.count
      post categories_path, params: {category: { name: 'Travel' }}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(categories_path)
      expect(Category.count - before_count).to eq(0)
    end
  end

  #======================================================================================================#

  context '/PATCH or /PUT request' do
    let!(:category) {Category.create(name: "Patch category")}

    it 'should update category (admin)' do
      sign_in(admin=true)
      before_count = Category.count
      patch category_path(category), params: {category: {name: 'Edit Name'}}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(category_path(category))
      follow_redirect!
      expect(response).to be_successful
      expect(response.body).to include('Edit Name')
      expect(Category.count - before_count).to eq(0)
    end

    it 'should not update category (non-admin)' do
      sign_in
      before_count = Category.count
      patch category_path(category), params: {category: {name: 'Edit Name'}}

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(categories_path)

      follow_redirect!
      expect(Category.count - before_count).to eq(0)
    end
  end

  #======================================================================================================#

  context '/DELETE request' do
    let!(:category) {Category.create(name: "delete-category")}

    it 'should delete category (admin)' do
      before_count = Category.count
      sign_in(admin=true)
      delete category_path(category)
      expect(response).to redirect_to(categories_path)
      follow_redirect!
      expect(response).to be_successful
      expect(before_count - Category.count).to eq(1)
    end

    it 'should not delete category (non-admin)' do
      before_count = Category.count
      sign_in
      delete category_path(category)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(categories_path)
      follow_redirect!
      expect(before_count - Category.count).to eq(0)
    end
  end
end