module Api::V1
  class ArticlesController < ApplicationController
    def index
      @user_ranks = User.where('ave_rate != 0 && review_count >= 5').order(ave_rate: 'DESC').limit(3)
      @tags = Article.tag_counts.order('taggings_count DESC').limit(10)
      @articles = Article.with_rich_text_content.includes(
        :user, :liked_users, :likes, :comments, :taggings, :tags
      ).paginate(page: params[:page], per_page: 5)
      @articles_count = Article.all.with_rich_text_content.includes(
        :user, :liked_users, :likes, :comments, :taggings, :tags
      ).count
    end

    def logged_in_index
      @user_ranks = User.where('ave_rate != 0 && review_count >= 5').order(ave_rate: 'DESC').limit(3)
      @tags = Article.tag_counts.order('taggings_count DESC').limit(10)
      @user = User.find(params[:user_id])
      @feed_items = @user.feed.with_rich_text_content.includes(
        :user, :liked_users, :likes, :comments, :taggings, :tags
      ).paginate(page: params[:page], per_page: 5)
      @likes = @user.liked_articles
      @logged_in_articles_count = @user.feed.with_rich_text_content.includes(
        :user, :liked_users, :likes, :comments, :taggings, :tags
      ).count
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

    def all
      @articles = Article.all.with_rich_text_content.includes(
        :user, :liked_users, :likes, :comments, :taggings, :tags
      )
      render json: @articles.map(&:id)
    end
  end
end
