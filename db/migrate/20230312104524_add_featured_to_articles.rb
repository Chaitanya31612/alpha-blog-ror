class AddFeaturedToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :featured, :boolean, default: false
  end
end
