class Review < ActiveRecord::Base

  USER_ALREADY_REVIEWED_ERROR_MESSAGE = "has reviewed this restaurant already"

  validates :user, uniqueness: {scope: :restaurant, message: USER_ALREADY_REVIEWED_ERROR_MESSAGE}
  validates :user, presence: true
  validates :rating, inclusion: (1..5)
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements

  def endorse_by(user, endorsement_class: Endorsement)
    endorsement = endorsement_class.new(user: user, review: self)
    return endorsement.errors.messages[:user].first if !endorsement.save
  end

end
