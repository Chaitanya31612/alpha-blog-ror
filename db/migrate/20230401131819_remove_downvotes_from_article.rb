class RemoveDownvotesFromArticle < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :downvotes
  end
end
