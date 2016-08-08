FactoryGirl.define do
  factory :bid do
    association :user, factory: :user
    association :auction, factory: :auction, current_price: 0

    bid_date    { Time.now - rand(120).days }
    offer_price { 11 + rand(1000) }
  end

  factory :low_bid, class: Bid do
    association :user, factory: :user
    association :auction, factory: :auction, current_price: 0

    bid_date    { Time.now - rand(120).days }
    offer_price 0
  end
end
