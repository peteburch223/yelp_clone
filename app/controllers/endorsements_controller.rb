class EndorsementsController < ApplicationController
  def create
    if current_user.nil?
      flash[:alert] = 'You need to sign in or sign up before continuing.'
      redirect_to restaurants_path
      return
    end
    review = Review.find(params[:review_id])
    if current_user.endorser_of?(review)
      flash[:alert] = 'Cannot re-endorse review'
      redirect_to restaurants_path
      return
    end
    Endorsement.create(user: current_user, review: review)
    redirect_to restaurants_path
  end
end
