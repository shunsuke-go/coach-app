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
      ave_rate = num_point(@reviews)
      @user.update_columns(ave_rate: ave_rate)

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
    ave_rate = num_point(@reviews)
    @user.update_columns(ave_rate: ave_rate)
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
    @ave_rate = @user.ave_rate.round(1) unless @user.ave_rate.nil?
  end

  def ave_point_cal
    user = User.find(params[:user_id])
    ave_points = { ave_points: user.ave_rate.to_f.round(1) }
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
      @point = point / reviews.count.to_f
    end
end
