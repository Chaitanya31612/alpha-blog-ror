class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles

  validates :username, presence: true, length: { in: 3..25 },
            uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
  validates :email, presence: true, uniqueness: true,
            format: { with: VALID_EMAIL_REGEX, multiline: true}

  has_secure_password
end