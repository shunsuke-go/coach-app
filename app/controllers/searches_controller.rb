class SearchesController < ApplicationController
  def index
    @keyword = Article.ransack(params[:q])
    @articles = @keyword.result.with_rich_text_content.includes(
      :user, :liked_users, :likes, :comments, :taggings, :tags
    ).paginate(page: params[:page], per_page: 5)
    if @articles.empty?
      gon.no_article = 1
    else
      gon.no_article = nil
    end
  end
end
