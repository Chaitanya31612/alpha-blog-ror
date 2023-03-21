require 'rails_helper'

RSpec.describe Article, type: :model do
  before(:each) do
    @user = User.new(username: 'chaitanya1', email: 'chaitanya1@example.com', password: 'abcedd')
    @article = Article.new(title: 'Article title', description: 'Article description it is')
    @article.user = @user
  end
  # let(:user) {User.new(username: 'chaitanya1', email: 'chaitanya1@example.com', password: 'abcedd')}
  # let(:article) {Article.new(title: 'Article title', description: 'Article description it is')}

  context 'validation tests' do
    # let(:user1) {User.new(username: 'chaitanya', email: 'chaitanya@example.com', password: 'abcedd')}
    # let(:article) {Article.new(title: 'Article title', description: 'Article description it is')}

    it 'check correct validation' do
      expect(@article).to be_valid
    end

    it 'ensure user is valid' do
      expect(@article.user).to be_valid
    end
  end

  context 'description validation tests' do
    # let(:article) {Article.new(title: 'Article title', user_id: 1)}
    it 'ensure description is present' do
      @article.description = " "
      expect(@article).not_to be_valid
    end

    it 'ensure description to have minimum length of 10' do
      @article.description = 'Articlee' # length 9
      expect(@article).not_to be_valid
    end
  end

  context 'user_id validation tests' do
    # let(:article) {Article.new(title: 'Article title', description: 'Article description it is')}

    it 'ensure user_id is present' do
      @article.user = nil
      expect(@article).not_to be_valid
    end

  end

  context "title validation tests" do
    # let(:article) {Article.new(title: "some title", description: "some description", user_id: 1)}

    it "ensure title is present" do
      @article.title = " "
      expect(@article).not_to be_valid
    end

    it "ensure title length is minimum 6" do
      @article.title = "aabbc"
      expect(@article).not_to be_valid
    end

    it "title length can be equal than 6" do
      @article.title = "aaabbb"
      expect(@article).to be_valid
    end

    it "ensure title length is less than or equal to 30" do
      @article.title = "a" * 31
      expect(@article).not_to be_valid
    end

    it "title length can be equal to 30" do
      @article.title = "a" * 30
      expect(@article).to be_valid
    end
  end
end