class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :reviewed_id
      t.text :content
      t.integer :rate

      t.timestamps
    end
    add_index :reviews,:reviewer_id
    add_index :reviews,:reviewed_id
  end
end
