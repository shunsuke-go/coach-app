module Api::V1
  class LikesController < ApplicationController
    def create
      @article = Article.find(params[:article_id])
      @like = @article.likes.build
      @user = User.find(params[:user_id])
      @like.user_id = @user.id
      @article.create_like_notification(@user)
      @like.save
      render json:
      {
        liked_articles: @user.liked_articles,
        likes_count: @article.likes.count
      }
    end

    def destroy_target
      @like = Like.find_by(user_id: params[:user_id], article_id: params[:article_id])
      render json: @like
    end

    def destroy
      @user = User.find(params[:user_id])
      @article = Article.find(params[:article_id])
      @like = Like.find_by(user_id: @user.id, article_id: @article.id)
      @like.destroy
      render json:
      {
        liked_articles: @user.liked_articles,
        likes_count: @article.likes.count
      }
    end

    def count
      @article = Article.find(params[:article_id])
      count = { count: @article.likes.count }
      render json: count
    end
  end
end
