class AddIndexToEntries < ActiveRecord::Migration[6.0]
  def change
    add_index :entries, [:room_id,:user_id],unique: true
  end
end
