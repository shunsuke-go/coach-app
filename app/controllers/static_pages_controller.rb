class StaticPagesController < ApplicationController
  def home
    @user_ranks = User.where('ave_rate != 0').order(ave_rate: 'DESC').limit(3)
    if logged_in?
      @article = current_user.articles.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @likes = current_user.liked_articles  
    else
      @articles = Article.paginate(page: params[:page], per_page: 5)
    end
  end

  def help
  end
end
