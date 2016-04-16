require 'rails_helper'

describe Review, type: :model do

  let(:user) { create(:user) }
  let(:restaurant) { build(:restaurant) }
  let(:endorsement) { build(:endorsement) }
  subject(:review) { build(:review) }
  let(:review2)  { build(:review) }

  it { is_expected.to belong_to :restaurant }
  it { is_expected.to belong_to :user }

  it { is_expected.to respond_to :endorse_by}

  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

  it 'is invalid if the user and restaurant FKs are the same', focus: false do
    link_review_with_restaurant_and_user(review, restaurant, user)
    link_review_with_restaurant_and_user(review2, restaurant, user)
    expect(review2).to have(1).error_on(:user)
  end

  context '#endorse_by' do
    it 'should return nil if there are no errors' do
      expect(review.endorse_by(user)).to eq nil
    end

    it 'should return multiple endorsement error message if review already endorsed by user' do
      link_endorsement_with_review_and_user(review, endorsement, user)
      expect(review.endorse_by(user)).to eq Endorsement::USER_ALREADY_ENDORSED_ERROR_MESSAGE
    end
  end

end
