module Api::V1
  class LikesController < ApplicationController
    before_action :authenticate

    def count
      @article = Article.find(params[:article_id])
      count = { count: @article.likes.count }
      render json: count
    end
  end
end
