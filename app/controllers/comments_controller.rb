class CommentsController < ApplicationController

  def create 
    
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id

    
    
    
    if @comment.save
      @article.create_comment_notification(current_user,@comment)
      flash[:success] = "コメントしました！"
      respond_to do |format|
        format.html {redirect_to article_url(@article)}
        format.js
      end
    else 
      flash[:danger] = "送信に失敗しました"
      render 'error'
    
    end
    
  end
  


  def destroy
    #article_id  params[:id] ← commentのid
    
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id]).destroy
    @comment.destroy
    #redirect_to article_url(@article)
    
  end

private
  def comment_params
    params.require(:comment).permit(:content)
  end  

end
