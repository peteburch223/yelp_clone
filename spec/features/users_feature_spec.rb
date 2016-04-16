require 'rails_helper'

feature "User can sign in and out" do

  let(:user) { build(:user) }
  let(:restaurant) { build(:restaurant) }
  let(:review) { build(:review) }

  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link("Sign in")
      expect(page).to have_link("Sign up")
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      user_sign_up(user)
    end

    it "should see 'sign out' link", js: false do
      visit('/')
      expect(page).to have_link("Sign out")
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  context 'restrictions' do
    it 'cannot create restaurants when not logged in' do
      visit('/')
      click_link 'Add a restaurant'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it 'cannot review restaurants when not logged in' do
      link_restaurant_and_user(user, restaurant)
      visit '/'
      click_link ("Review #{restaurant.name}")
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end


    xit 'cannot endorse restaurants when not logged in' do
      link_restaurant_and_user(user, restaurant)
      link_review_with_restaurant_and_user(review, restaurant, user)
      visit '/'
      click_link ("Endorse")
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end


    it 'can review restaurants when logged in' do
      user_sign_up(user)
      link_restaurant_and_user(user, restaurant)
      visit '/'
      click_link ("Review #{restaurant.name}")
      expect(page).not_to have_content('You need to sign in or sign up before continuing.')
    end

  end
end
