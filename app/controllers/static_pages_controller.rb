class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @article = current_user.articles.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @likes = current_user.liked_articles
      
    

    end
  end

  def help
  end
  
end
  