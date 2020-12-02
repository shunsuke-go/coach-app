class ReviewsController < ApplicationController
  def create
    @user = User.find_by(id: params[:user_id])
    @review = Review.new(review_params)
    @review.reviewer_id = current_user.id
    @review.reviewed_id = @user.id
    @reviews = @user.passive_reviews

    if @review.save
      flash[:success] = "レビューを書き込みました"

      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js
      end
    else  
      redirect_to user_path(@user),flash:{danger: @review.errors.full_messages}
    end
  end

  def destroy

    
    @user = User.find_by(id: params[:user_id])
    @review = Review.find_by(id: params[:id])
    @reviews = @user.passive_reviews
    
    @review.destroy


    flash[:success] = "削除しました"
    
    respond_to do |format|
      format.html { redirect_to user_path(params[:user_id]) }
      format.js
    end
  end
  


  private
  def review_params
    params.require(:review).permit(:content,:rate)
  end
end
