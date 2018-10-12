class PlacesController < ApplicationController
  def index
  end

  def show
    @places = BeermappingApi.places_in(session[:last_api_search])
    redirect_to places_path, notice: "Error: The selected place was not found!" if @places.empty?
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No places found in #{params[:city]}"
    else
      @weather = ApixuApi.weather_in(params[:city])
      session[:last_api_search] = params[:city]
      render :index
    end
  end
end
