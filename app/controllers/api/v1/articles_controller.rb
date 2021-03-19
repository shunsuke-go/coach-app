module Api::V1
  class ArticlesController < ApplicationController
    def index
      @user_ranks = User.where('ave_rate != 0 && review_count >= 5').order(ave_rate: 'DESC').limit(3)
      @tags = Article.tag_counts.order('taggings_count DESC').limit(10)
      if logged_in?
        @article = current_user.articles.build
        @articles = current_user.feed.with_rich_text_content.includes(
          :user, :liked_users, :likes, :comments, :taggings, :tags
        ).paginate(page: params[:page], per_page: 5)
        @likes = current_user.liked_articles
      else
        @articles = Article.with_rich_text_content.includes(
          :user, :liked_users, :likes, :comments, :taggings, :tags
        ).paginate(page: params[:page], per_page: 5)
      end
    end

    def show
      @article = Article.find(params[:id])
      @user = @article.user
      @comment = @article.comments.build
      @comments = @article.comments.all
      @like = @article.likes.build
      @tags = @article.tag_counts_on(:tags)
      @map = Map.find_by(article_id: @article.id)
      @reviews = @user.passive_reviews
      @ave_rate = @user.ave_rate.round(1) unless @user.ave_rate.nil?
      @profile = Profile.find_by(user_id: @user.id)
      if logged_in?
        @room = @user.users_room(current_user)
        if @room.blank?
          @room = Room.new
          @entry = Entry.new
        end
      end
      unless @map.nil?
        gon.latitude = @map.latitude
        gon.longitude = @map.longitude
      end
    end
  end
end
