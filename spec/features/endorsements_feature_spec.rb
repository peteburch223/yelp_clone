require 'rails_helper'

feature 'endorsing reviews' do

  let(:restaurant) { build(:restaurant) }
  let(:user1) { create(:user) }
  let(:review) { build(:review) }

  before do
    link_restaurant_and_user(user1, restaurant)
    link_review_with_restaurant_and_user(review, restaurant, user1)
  end

  scenario 'A user can endorse a review, which increments the restaurant endorsement count' do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 Endorsement')
  end



end
