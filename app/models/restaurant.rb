class Restaurant < ActiveRecord::Base
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user
  validates :user, presence: true
  has_many :reviews, dependent: :destroy
  has_many :user_reviews, through: :reviews, source: :user

  def build_review(review_params, user)
    review = Review.new(review_params)
    review.restaurant = self
    review.user = user
    review.save
  end

end
