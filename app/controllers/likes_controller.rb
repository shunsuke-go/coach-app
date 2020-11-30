class LikesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @like = @article.likes.build
    @like.user_id = current_user.id

    # 通知
    @article.create_like_notification(current_user)
  
      
    if @like.save
    
    respond_to do |format|
      format.html {redirect_to article_url(@article)}
      format.js
    end
    

    else
      flash[:danger] = "いいねに失敗しました。"
      redirect_to article_url(@article)
    end
  end

  def destroy
    
    @article = Article.find_by(id: params[:article_id])
    @like = Like.find_by(id: params[:id])
    @like.destroy

    respond_to do |format|
      format.html {redirect_to article_url(@article)}
      format.js
    end
  end

  def index
    @likes = current_user.liked_articles
  end

end
