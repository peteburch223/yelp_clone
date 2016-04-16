class EndorsementsController < ApplicationController

  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    flash[:alert] = review.endorse_by(current_user)
    render json: {new_endorsement_count: review.endorsements.count}
    # redirect_to restaurants_path
  end

end
