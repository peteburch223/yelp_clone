FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email) { |n| "user#{n}@gmail.com" }
    u.password 'abcdefg123'
    u.password_confirmation 'abcdefg123'
  end

  factory :restaurant do
    name 'GBK'
    description 'Gourmet Burger Kitchen'
  end

  # factory :review do |r|
  #   r.thoughts 'I think very deeply'
  #   r.sequence(:rating) {|n| [3,1][n-1]}
  # end

  factory :review do |r|
    r.thoughts 'I think very deeply'
    r.rating 3
  end

end
