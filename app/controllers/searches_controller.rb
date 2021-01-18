class SearchesController < ApplicationController
  def index
    @keyword = Article.ransack(params[:q])
    @articles = @keyword.result
  end
end
