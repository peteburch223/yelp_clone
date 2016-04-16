require 'rails_helper'

feature 'endorsing reviews', focus: true  do

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:restaurant) { build(:restaurant) }
  let(:review) { build(:review) }

  before do
    link_restaurant_and_user(user1, restaurant)
    link_review_with_restaurant_and_user(review, restaurant, user1)
    user_sign_in(user1)
  end

  scenario 'A user can endorse a review, which increments the restaurant endorsement count' do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'error message displayed if user attempts to endorse review multiple times' do
    visit '/restaurants'
    click_link 'Endorse Review'
    click_link 'Endorse Review'
    expect(page).to have_content("Cannot re-endorse review")
  end

  scenario 'restaurants page displays multiple endorsements' do
    visit '/restaurants'
    click_link 'Endorse Review'
    click_link 'Sign out'
    user_sign_in(user2)
    click_link 'Endorse Review'
    expect(page).to have_content('2 endorsements')
  end
end
