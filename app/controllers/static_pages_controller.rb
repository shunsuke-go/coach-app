class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @article = current_user.articles.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @likes = current_user.liked_articles  
      @user_ranks = User.where("ave_rate IS NOT NULL").order(ave_rate: "DESC").limit(3)      
    end
  end

  def help
  end
  
end
  