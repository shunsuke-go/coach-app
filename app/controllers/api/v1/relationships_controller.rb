module Api::V1
  class RelationshipsController < ApplicationController
    before_action :authenticate

    def followers_count
      @user = User.find(params[:user_id])
      count = { count: @user.followers.count }
      render json: count
    end
  end
end
