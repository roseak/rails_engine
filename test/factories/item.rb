FactoryGirl.define do
  factory :item do
    name { Faker::Hipster.words(1) }
    description { Faker::Hipster.sentence }
    unit_price { Faker::Number.decimal(4, 2) }
    merchant
  end
end
