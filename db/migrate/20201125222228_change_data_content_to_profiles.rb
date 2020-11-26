class ChangeDataContentToProfiles < ActiveRecord::Migration[6.0]
  def change
    change_column :profiles, :content, :text
  end
end
