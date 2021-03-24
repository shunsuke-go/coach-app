class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @article = Article.new
    @article.build_map
  end

  def show
    redirect_to("#{ENV['FRONT_URL']}/articles/#{params[:id]}")
    # @article = Article.find(params[:id])
    # @user = @article.user
    # @comment = @article.comments.build
    # @comments = @article.comments.all
    # @like = @article.likes.build
    # @tags = @article.tag_counts_on(:tags)
    # @map = Map.find_by(article_id: @article.id)
    # @reviews = @user.passive_reviews
    # @ave_rate = @user.ave_rate.round(1) unless @user.ave_rate.nil?
    # @profile = Profile.find_by(user_id: @user.id)
    # if logged_in?
    #   @room = @user.users_room(current_user)
    #   if @room.blank?
    #     @room = Room.new
    #     @entry = Entry.new
    #   end
    # end

    # return if @map.nil?

    # gon.latitude = @map.latitude
    # gon.longitude = @map.longitude
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      latitude = params[:article][:map][:latitude]
      longitude = params[:article][:map][:longitude]
      address = params[:article][:map][:address]

      unless latitude.empty?
        @map = @article.build_map(
          latitude: latitude,
          longitude: longitude,
          address: address.slice(3, 30)
        )
        # @map.address = @map.address_search(latitude, longitude)
        @map.save
      end

      flash[:success] = '投稿しました！'

      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end

    else
      render 'articles/new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    @map = Map.find_by(article_id: @article.id)
    return if @map.nil?

    gon.latitude = @map.latitude
    gon.longitude = @map.longitude
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      latitude = params[:article][:map][:latitude]
      longitude = params[:article][:map][:longitude]
      address = params[:article][:map][:address]
      unless latitude.empty?
        @map = @article.build_map(
          latitude: latitude,
          longitude: longitude,
          address: address.slice(3, 50)
        )
        @map.save
      end

      flash[:success] = '更新しました'
      redirect_to root_path
    else
      flash[:danger] = '更新に失敗しました'
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = '削除しました！'
    redirect_to root_path
  end

  def index
    @tag = params[:tag_name]
    @articles = Article.tagged_with(params[:tag_name].to_s).paginate(page: params[:page], per_page: 5)
  end

  def tags
    @tags = Article.tag_counts.order('taggings_count DESC')
    render 'tags/tags'
  end

  private

    def article_params
      params.require(:article)
            .permit(:content, :title, :tag_list, :thumbnail, map_attributes: [:id, :address, :latitude, :longitude])
    end
end
