FactoryGirl.define do
  factory :invoice_item do
    unit_price { Faker::Number.between(100, 100000) }
    quantity { Faker::Number.number(1) }
    item
    invoice
  end
end
