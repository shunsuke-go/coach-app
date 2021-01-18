class SearchesController < ApplicationController
  def index
    @keyword = Article.ransack(params[:q])
    @articles = @keyword.result()
    
    binding.pry
    
  end
end
