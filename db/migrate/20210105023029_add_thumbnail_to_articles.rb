class AddThumbnailToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :thumbnail, :string
  end
end
