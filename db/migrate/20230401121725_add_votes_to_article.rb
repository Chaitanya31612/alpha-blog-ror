class AddVotesToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :upvotes, :integer, default: 0
    add_column :articles, :downvotes, :integer, default: 0
  end
end
