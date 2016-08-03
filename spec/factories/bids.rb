FactoryGirl.define do
  factory :bid do
    association :user, factory: :user
    association :auction, factory: :auction, current_price: 0

    bid_date    { Time.now - rand(120).days }
    offer_price { rand(1000) }
  end
end
