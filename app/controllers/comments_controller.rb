class CommentsController < ApplicationController

  def create 
    
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    @comment.user_id = current_user.id
    
    
    
    
    if @comment.save
      flash[:success] = "コメントしました！"
      redirect_to article_url(article)
    
    else 
      flash[:danger] = "送信に失敗しました"
      redirect_to root_url
    
    end
    
  end
  


  def destroy
    #article_id  params[:id] ← commentのid
    
    article = Article.find(params[:article_id])
    Comment.find(params[:id]).destroy
    redirect_to article_url(article)
    
  end

private
  def comment_params
    params.require(:comment).permit(:content)
  end  

end
