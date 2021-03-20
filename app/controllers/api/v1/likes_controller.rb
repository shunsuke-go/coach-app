module Api::V1
  class LikesController < ApplicationController
    def create
      @article = Article.find(params[:article_id])
      @like = @article.likes.build
      @user = User.find(params[:user_id])
      @like.user_id = @user.id
      @article.create_like_notification(@user)
      @like.save
      render json: @user.liked_articles
    end

    def destroy_target
      @like = Like.find_by(user_id: params[:user_id], article_id: params[:article_id])
      render json: @like
    end

    def destroy
      @user = User.find(params[:user_id])
      @like = Like.find(params[:id])
      @like.destroy
      render json: @user.liked_articles
    end

    def count
      @article = Article.find(params[:article_id])
      count = { count: @article.likes.count }
      render json: count
    end
  end
end
