class AddColumnToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :checked, :boolean, default: false, null: false
  end
end
