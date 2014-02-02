class RatingsController < ApplicationController
  def index
     @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    # sama kuin Rating.beer beer_id:"1", score:"30"
    # params: { "beer_id"=>"1", "score"=>"30"}
    Rating.create params.require(:rating).permit(:score, :beer_id)
    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end