require 'rails_helper'

feature 'reviewing' do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:restaurant) { build(:restaurant) }

  before do
    link_restaurant_and_user(user, restaurant)
    user_sign_in(user)
  end

  scenario 'allows users to leave a review using a form' do
    review(restaurant: restaurant)
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content(ReviewHelpers::THOUGHTS)
  end

  scenario 'displays average rating', focus: true do
    review(restaurant: restaurant, thoughts: 'so-so', rating: 3)
    click_link 'Sign out'
    user_sign_in(user2)
    review(restaurant: restaurant, thoughts: 'rubbish', rating: 1)
    # expect(page).to have_content("Average rating: 2")
    expect(page).to have_content('Average rating: ★★☆☆☆')
  end
end
