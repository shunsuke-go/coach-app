class AddNotNullRelationships < ActiveRecord::Migration[6.0]
  def change
    change_column_null :relationships, :follower_id, false
    change_column_null :relationships, :followed_id, false
  end 
end
