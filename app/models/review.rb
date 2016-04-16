class Review < ActiveRecord::Base

  validates :user, uniqueness: {scope: :restaurant, message: "has reviewed this restaurant already"}
  validates :user, presence: true
  validates :rating, inclusion: (1..5)
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements

end
