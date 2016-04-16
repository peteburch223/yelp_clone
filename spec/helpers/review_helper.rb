module ReviewHelpers

  THOUGHTS = 'so-so'
  RATING = 3

  def link_review_with_restaurant_and_user(review, restaurant, user)
    review.restaurant = restaurant
    review.user = user
    review.save
  end

  def review(restaurant: ,
             thoughts: THOUGHTS,
             rating: RATING)
    visit '/restaurants'
    click_link "Review #{restaurant.name}"
    fill_in "Thoughts", with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
end
