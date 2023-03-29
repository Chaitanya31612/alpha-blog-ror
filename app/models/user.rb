class User < ApplicationRecord
  before_save { self.email = email.downcase }

  # Will return an array of follows for the given user instance
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"

  # Will return an array of users who follow the user instance
  has_many :followers, through: :received_follows, source: :follower, dependent: :destroy

  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"

  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user, dependent: :destroy

  has_many :articles, dependent: :destroy

  validates :username, presence: true, length: { in: 3..25 },
            uniqueness: true
  VALID_EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
  validates :email, presence: true, uniqueness: true,
            format: { with: VALID_EMAIL_REGEX, multiline: true}

  has_secure_password

  def follow(user)
    followings << user
  end

  def unfollow(followed_user)
    followings.delete followed_user
  end

  def following?(user)
    followings.include?(user)
  end
end