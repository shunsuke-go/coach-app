class LikesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @like = @article.likes.build
    @like.user_id = current_user.id

    # 通知
    @article.create_like_notification(current_user)
  
      
    if @like.save
      redirect_to article_url(@article)

    else
      flash[:danger] = "いいねに失敗しました。"
      redirect_to article_url(@article)
    end
  end

  def destroy
    
    @article = Article.find_by(id: params[:article_id])
    Like.find_by(id: params[:id]).destroy
    redirect_to article_url(@article)
    
  end

  def index
    @likes = current_user.liked_articles
  end

end
