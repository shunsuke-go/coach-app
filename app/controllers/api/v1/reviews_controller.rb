module Api::V1
  class ReviewsController < ApplicationController
    before_action :authenticate
    def index
      @user = User.find(params[:user_id])
      @reviews = @user.passive_reviews
    end
  end
end
