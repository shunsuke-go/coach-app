class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.bigint :user_id, null: false
      t.bigint :article_id, null: false

      t.timestamps
    end
    add_foreign_key :likes, :users
    add_foreign_key :likes, :articles
  end
end
