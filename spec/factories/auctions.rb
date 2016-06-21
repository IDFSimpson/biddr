FactoryGirl.define do
  factory :auction do
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}" }
    details          { Faker::Hipster.paragraph       }
    reserve_price    { 11 + rand(100000)              }
    ends             { Time.now + rand(120).days      }
  end

  factory :auction_with_current_price do
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}" }
    details          { Faker::Hipster.paragraph       }
    reserve_price    { 11 + rand(100000)              }
    current_price    { 11 + rand(100000)              }
    ends             { Time.now + rand(120).days      }
  end
end
