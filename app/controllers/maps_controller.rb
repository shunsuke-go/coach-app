class MapsController < ApplicationController

  def new
    @map = Map.new
  end


  def index
    
    @articles = []
    @gmaps = Map.near(params[:area],20,units: :km)
    
    @gmaps.each do |gmap|
    @articles.push(gmap.article)
    end
    
  end

end
