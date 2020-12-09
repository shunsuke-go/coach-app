class ArticlesController < ApplicationController
  before_action :logged_in?,only:[:create,:destroy]
  before_action :correct_user,only:[:destroy]

    def new
      @article = Article.new
    end


    def show
      @article = Article.find(params[:id])
      @comment = @article.comments.build
      @comments = @article.comments.all
      @like = @article.likes.build
      @tags = @article.tag_counts_on(:tags)
    end

    def create
      
      binding.pry
      
      @article = current_user.articles.build(article_params)
      if @article.save
        flash[:success] = "投稿しました！"
        
        respond_to do |format|
          format.html { redirect_to root_url }
          format.js
        end

      else
        @article = Article.new
        redirect_to new_article_path
      end
    end

    def destroy
      @article.destroy
      flash[:success] = "削除しました！"
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url}
        format.js
      end
    end

    def index
      
        @tag = params[:tag_name]
        @articles = Article.tagged_with("#{params[:tag_name]}").paginate(page: params[:page],per_page: 5)
      
    end  


    def tags
      @tags = Article.tag_counts
      render 'tags/_tag_all'
    end
  
private
  # Strong Parameter
    def article_params
        params.require(:article).permit(:content,:title,:tag_list)         
    end

    

  # 削除する記事を取得する。削除前に行う。
    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end


end
