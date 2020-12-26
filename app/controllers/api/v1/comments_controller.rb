module Api::V1
  class CommentsController < ApplicationController
    before_action :authenticate

    def index
      @article = Article.find(params[:article_id])
      @comments = @article.comments.all
    end
  end
end
