class RestaurantsController < ApplicationController

  def new
  end

  def index
    @restaurants = Restaurant.all
  end

  def create
    Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

  def restaurant_params
    p params
    params.require(:restaurant).permit(:name)
  end
end
