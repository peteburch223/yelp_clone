module RestaurantHelpers
  def create_restaurant(name: 'KFC')
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
  end
end
