require 'rails_helper'

feature 'endorsing reviews' do

  let(:user1) { create(:user) }
  let(:restaurant) { build(:restaurant) }
  let(:review) { build(:review) }

  before do
    link_restaurant_and_user(user1, restaurant)
    link_review_with_restaurant_and_user(review, restaurant, user1)
    user_sign_up(user1)
  end

  xscenario 'A user can endorse a review, which increments the restaurant endorsement count' do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

  xscenario 'error message displayed if user attempts to endorse review multiple times' do
    visit '/restaurants'
    click_link 'Endorse Review'
    click_link 'Endorse Review'
    expect(page).to have_content("#{user1.email} has endorsed this review already")
  end

  xscenario 'restaurants page displays multiple endorsements' do
    visit '/restaurants'
    click_link 'Endorse Review'
    click_link 'Endorse Review'
    expect(page).to have_content('2 endorsements')
  end
end
