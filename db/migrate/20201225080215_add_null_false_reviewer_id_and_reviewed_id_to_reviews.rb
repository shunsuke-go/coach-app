class AddNullFalseReviewerIdAndReviewedIdToReviews < ActiveRecord::Migration[6.0]
  def change
    change_column_null :reviews, :reviewer_id, null: false
    change_column_null :reviews, :reviewed_id, null: false    
  end
end
