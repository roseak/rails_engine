FactoryGirl.define do
  factory :item do
    name { Faker::Lorem.words(1) }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.between(100, 100000) }
    merchant
  end
end
