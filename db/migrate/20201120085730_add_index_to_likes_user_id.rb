class AddIndexToLikesUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :likes,[:user_id,:article_id], unique: true
  end
end
