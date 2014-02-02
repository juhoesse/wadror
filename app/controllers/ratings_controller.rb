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
    #rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    #current_user.ratings << rating
    #redirect_to current_user

    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end