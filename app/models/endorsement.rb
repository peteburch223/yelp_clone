class Endorsement < ActiveRecord::Base
  validates :user, uniqueness: {scope: :review, message: "has endorsed this review already"}
  # validates :user, presence: true
  #
  belongs_to :user
  belongs_to :review
end
