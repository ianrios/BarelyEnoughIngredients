class RatingsController < ApplicationController
  def index
  end

  def show
  end
  #this code creates a new rating
  def new
    @rating = Rating.new
  end
  #this code allows a user to add the proper data to the recipe
  def create
    rating = Rating.new(rating_params)
    rating.save!
    redirect_to action: 'index'
  end
  #this code required the proper rating information
  def rating_params 
    params.require(:rating).permit(:recipe_id, :rating)
  end
end
