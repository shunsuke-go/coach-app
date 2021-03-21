module Api::V1
  class RelationshipsController < ApplicationController
    def create
      @following_user = User.find(params[:user_id])
      @followed_user = User.find(params[:followed_id])
      @following_user.follow(@followed_user)
      @following_user.create_follow_notification(@following_user, @followed_user)
      render json: @followed_user.followers.count
    end

    def destroy
      @following_user = User.find(params[:user_id])
      @followed_user = Relationship.find(params[:followed_id]).followed
      following_user.unfollow(@followed_user)
    end

    def followers_count
      @user = User.find(params[:user_id])
      count = { count: @user.followers.count }
      render json: count
    end
  end
end
