class StaticPagesController < ApplicationController
  def home
    redirect_to(ENV['FRONT_URL'])
    # @user_ranks = User.where('ave_rate != 0 && review_count >= 5').order(ave_rate: 'DESC').limit(3)
    # @tags = Article.tag_counts.order('taggings_count DESC').limit(10)
    # if logged_in?
    #   @article = current_user.articles.build
    #   @feed_items = current_user.feed.with_rich_text_content.includes(
    #     :user, :liked_users, :likes, :comments, :taggings, :tags
    #   ).paginate(page: params[:page], per_page: 5)

    #   @likes = current_user.liked_articles
    # else
    #   @articles = Article.with_rich_text_content.includes(
    #     :user, :liked_users, :likes, :comments, :taggings, :tags
    #   ).paginate(page: params[:page], per_page: 5)      
    # end
  end
end
