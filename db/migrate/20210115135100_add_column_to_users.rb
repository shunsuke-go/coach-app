class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coach, :boolean, default: false
  end
end
