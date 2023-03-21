require 'rails_helper'

RSpec.describe User, type: :model do
  context 'username validation tests' do
    let(:user) {User.new(email: "test@email.com", password: "123456")}
    it 'ensure username is present' do
      # expect(user.save).to be_falsey
      expect(user).not_to be_valid
    end

    it 'ensure length greater than or equal to 3' do
      user.username = 'ab'
      expect(user).not_to be_valid
      # expect(user.save).to be_falsey
    end

    it 'ensure length less than or equal to 25' do
      user.username = 'a'*26
      expect(user).not_to be_valid
      # expect(user.save).to be_falsey
    end

    it 'ensure unique value' do
      user.username = 'Chaitanya'
      expect(user.save).to be_truthy
      user2 = User.new(username: 'Chaitanya', email: 'chaitanya@test.com', password: 'abcdef')
      expect(user2).not_to be_valid
      # expect(user2.save).to be_falsey
    end
  end

  context 'email validation tests' do
    let(:user) {User.new(username: "testuser", password: "123456")}

    it 'ensure email is present' do
      expect(user).not_to be_valid
      # expect(user.save).to be_falsey
    end

    it 'ensure email is unique' do
      user.email = 'test@example.com'
      expect(user.save).to be_truthy
      user2 = User.new(username: 'testuser1', email: 'test@example.com', password: 'abcded')
      expect(user2).not_to be_valid
      # expect(user2.save).to be_falsy
    end

    it 'ensure email has valid format' do
      user.email = 'test.com'
      expect(user).not_to be_valid
      # expect(user.save).to be_falsey
    end
  end

  context 'validation tests complete' do
    let(:user) {User.new(username: 'Chatanya', email: 'test@example.com', password: '1234567')}

    it 'ensure user is saved' do
      expect(user).to be_valid
      # expect(user.save).to be_truthy
    end
  end
end