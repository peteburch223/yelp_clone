def link_endorsement_with_review_and_user(review, endorsement, user)
  endorsement.review = review
  endorsement.user = user
  endorsement.save
end
