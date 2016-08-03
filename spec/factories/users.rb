FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| Faker::Internet.email.gsub("@", "-#{n}@") }
    password { Faker::Internet.password }
  end
end
