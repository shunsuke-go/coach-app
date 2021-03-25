module Api::V1
  class CommentsController < ApplicationController
    def index
      @article = Article.find(params[:article_id])
      @comments = @article.comments.all
    end

    def create
      @article = Article.find(params[:article_id])
      @comment = @article.comments.build(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        @article.create_comment_notification(current_user, @comment)
      else
        render json: '投稿に失敗しました'
      end  
    end

private
    def comment_params
      params.require(:comment).permit(:content)
    end

  end
end
