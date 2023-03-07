class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {minimum: 6, maximum: 30}
  validates :description, presence: true, length: {minimum: 10}

end
