class RatingsController < ApplicationController
  def index
    @ratings = Rails.cache.fetch("All ratings", expires_in: 10.minutes) { Rating.all }
    @recent_ratings = Rails.cache.fetch("Recent ratings", expires_in: 10.minutes) { Rating.recent }
    @top_beers = Rails.cache.fetch("Beer top 3", expires_in: 10.minutes) { Beer.top_rated(3) }
    @top_breweries = Rails.cache.fetch("Brewery top 3", expires_in: 10.minutes) { Brewery.top_rated(3) }
    @top_styles = Rails.cache.fetch("Style top 3", expires_in: 10.minutes) { Style.top_rated(3) }
    @top_users = Rails.cache.fetch("User top 3", expires_in: 10.minutes) { User.top(3) }
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if current_user.nil?
      redirect_to signin_path, notice: 'You should be signed in'
    elsif @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
