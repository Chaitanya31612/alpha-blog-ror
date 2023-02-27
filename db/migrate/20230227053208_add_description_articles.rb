class AddDescriptionArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :description, :text
  end
end
