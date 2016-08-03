FactoryGirl.define do
  factory :auction do
    association :user, factory: :user

    sequence(:title) {|n| "#{Faker::Commerce.product_name}-#{n}" }
    details          { Faker::Hipster.paragraph }
    reserve_price    { rand(100000) }
    ends             { Time.now + rand(120).days }
  end

  factory :auction_with_current_price do
    association :user, factory: :user

    sequence(:title) {|n| "#{Faker::Commerce.product_name}-#{n}" }
    details          { Faker::Hipster.paragraph }
    reserve_price    { rand(1000) }
    current_price    { rand(1000) }
    ends             { Time.now + rand(120).days }
  end
end
