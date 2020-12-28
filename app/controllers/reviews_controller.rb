class ReviewsController < ApplicationController
  def create
    @user = User.find_by(id: params[:user_id])
    @review = Review.new(review_params)
    @review.reviewer_id = current_user.id
    @review.reviewed_id = @user.id
    @reviews = @user.passive_reviews
    current_user.create_review_notification(current_user, @user)
    if @review.save
      flash[:success] = 'レビューを書き込みました'

      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.js
      end
    else
      render 'error'
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @review = Review.find_by(id: params[:id])
    @reviews = @user.passive_reviews

    @review.destroy

    flash[:success] = '削除しました'

    respond_to do |format|
      format.html { redirect_to user_path(params[:user_id]) }
      format.js
    end
  end

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @reviews = @user.passive_reviews
    @review = Review.new
  end

  def ave_point_cal
    user = User.find(params[:user_id])
    reviews = user.passive_reviews
    ave_points = { ave_points: num_point(reviews) }
    render json: ave_points
  end

  private

    def review_params
      params.require(:review).permit(:content, :rate)
    end

    def num_point(reviews)
      return 0 if reviews.count.zero?

      point = 0
      reviews.each do |review|
        point += review.rate
      end
      @point = point / reviews.count
    end
end
