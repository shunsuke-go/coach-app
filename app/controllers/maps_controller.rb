class MapsController < ApplicationController
  def new
    @map = Map.new
    render 'maps/_new_map'
  end

  def index
    @area = params[:area]
    @articles = []
    @gmaps = Map.near(@area, 20, units: :km).includes(
      article: [:user, :liked_users, :likes, :comments, :taggings, :tags]
    )
    @gmaps.each do |gmap|
      @articles.push(gmap.article)
    end

    @articles = @articles.paginate(page: params[:page], per_page: 5)
  end
end
