class ReviewsController < ApplicationController
  def create
    @user = User.find_by(id: params[:user_id])
    @review = Review.new(review_params)
    @review.reviewer_id = current_user.id
    @review.reviewed_id = @user.id

    if @review.save
      flash[:success] = "レビューを書き込みました"
      redirect_to user_path(@user)
    else  
      redirect_to user_path(@user),flash:{danger: @review.errors.full_messages}
    end
  end

  def destroy
    Review.find_by(id: params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to user_path(params[:user_id])
  end
  


  private
  def review_params
    params.require(:review).permit(:content,:rate)
  end
end
