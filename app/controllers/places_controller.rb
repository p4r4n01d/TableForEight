class PlacesController < ApplicationController
  API_KEY = 'AIzaSyAF4lesJD5jTyH-_LCnpwsJn6tA0avk1d4'
  
  
  # GET /api/places/:type
  def index
    @client = GooglePlaces::Client.new(API_KEY)
    @test = @client.spots_by_query(params[:type]+' Restaurants in Sydney', :keyword => params[:type], :types => ['restaurant','food'], :language => 'en')
    render json: @test 
  end

end
