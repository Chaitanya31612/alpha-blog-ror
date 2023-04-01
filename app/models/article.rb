class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: {minimum: 6, maximum: 30}
  validates :description, presence: true, length: {minimum: 10}

  def upvote
    self.upvotes += 1
  end
end
