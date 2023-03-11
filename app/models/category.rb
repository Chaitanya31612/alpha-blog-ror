class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { in: 3..25 }
end