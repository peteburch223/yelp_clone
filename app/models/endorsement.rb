class Endorsement < ActiveRecord::Base

  USER_ALREADY_ENDORSED_ERROR_MESSAGE = "Cannot re-endorse review"

  validates :user, uniqueness: {scope: :review, message: USER_ALREADY_ENDORSED_ERROR_MESSAGE}
  validates :user, presence: true
  belongs_to :user
  belongs_to :review
end
