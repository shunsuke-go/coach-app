class MapsController < ApplicationController
  def new
    @map = Map.new
    render 'maps/_new_map'
  end

  def index
    @area = params[:area]
    @articles = []
    @gmaps = Map.near(@area, 20, units: :km)

    @gmaps.each do |gmap|
      @articles.push(gmap.article)
    end
  end
end
