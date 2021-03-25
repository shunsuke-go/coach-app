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

    def index
      @articles = current_user.liked_articles.with_rich_text_content.includes(
        :user, :liked_users, :likes, :comments, :taggings, :tags
      )
      render json: @articles
    end

    def count
      @article = Article.find(params[:article_id])
      render json: @article.likes.count
    end
  end
end
