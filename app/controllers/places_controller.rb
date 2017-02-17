class PlacesController < ApplicationController

  def index

  end

  def show
    city = session[:city]
    @place = BeermappingApi.places_in(city).find{|alkio| alkio.id == params[:id]}
  end

    def search
      @places = BeermappingApi.places_in(params[:city])
      session[:city] = params[:city]
      if @places.empty?
        redirect_to places_path, notice: "No locations in #{params[:city]}"
      else
        render :index
      end
    end

end