class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id
      t.integer :visited_id
      t.references :article
      t.references :comment
      t.references :message
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
