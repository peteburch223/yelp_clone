require 'rails_helper'

feature "Setting limits on users", focus: true do

  let(:restaurant) { build(:restaurant) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:review) { build(:review) }

  before do
    link_restaurant_and_user(user1, restaurant)
    link_review_with_restaurant_and_user(review, restaurant, user1)
  end

  context 'User 2 signed in' do

    before {user_sign_in(user2)}

    scenario 'User can only edit restaurant they have created', js: false do
      click_link "Edit #{restaurant.name}"
      expect(page).not_to have_button 'Update Restaurant'
      expect(page).to have_content 'Cannot edit restaurant'
    end

    scenario 'User can only delete restaurant they have created', js: false do
      click_link "Delete #{restaurant.name}"
      expect(page).to have_content restaurant.name
      expect(page).to have_content 'Cannot delete restaurant'
    end
  end

  context 'User 1 signed in' do

    before {user_sign_in(user1)}

    scenario 'User can only edit restaurant they have created', js: false do
      click_link "Edit #{restaurant.name}"
      expect(page).to have_button 'Update Restaurant'
      expect(page).not_to have_content 'Cannot edit restaurant'
    end

    scenario 'User can only delete restaurant they have created', js: false do
      click_link "Delete #{restaurant.name}"
      expect(page).not_to have_content restaurant.name
      expect(page).not_to have_content 'Cannot delete restaurant'
    end
  end


  scenario 'User can only create one review per restaurant', js: false, focus: false do
    user_sign_in(user1)
    click_link "Review #{restaurant.name}"
    expect(page).not_to have_button 'Leave Review'
    expect(page).to have_content 'Cannot re-review restaurant'
  end

end
