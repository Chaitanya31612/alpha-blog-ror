class AddIndexInFollow < ActiveRecord::Migration[6.1]
  def change
  end

  add_index :follows, :follower_id
  add_index :follows, :followed_user_id
  add_index :follows, [:followed_user_id, :follower_id], unique: true
end
