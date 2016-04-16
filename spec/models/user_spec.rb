require 'rails_helper'

describe User, type: :model do

  subject(:user) { create(:user) }
  let(:restaurant) { build(:restaurant) }
  let(:review) { build(:review) }
  let(:endorsement) { build(:endorsement) }

  it { is_expected.to have_many(:restaurants)}
  it { is_expected.to have_many(:reviews)}
  it { is_expected.to have_many(:reviewed_restaurants)}
  it { is_expected.to have_many(:endorsements)}
  it { is_expected.to have_many(:endorsed_reviews)}

  before do
    link_restaurant_and_user(user, restaurant)
    link_review_with_restaurant_and_user(review, restaurant, user)
    link_endorsement_with_review_and_user(review, endorsement, user)

  end

  it '#creator_of?' do
    expect(user).to be_creator_of(restaurant)
  end

  it '#reviewer_of?' do
    expect(user).to be_reviewer_of(restaurant)
  end

  it '#author_of?' do
    expect(user).to be_author_of(review)
  end

  it '#endorser_of?' do
    expect(user).to be_endorser_of(review)
  end

end
