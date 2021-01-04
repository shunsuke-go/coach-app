class AddColumnAveRateToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ave_rate, :float
  end
end
