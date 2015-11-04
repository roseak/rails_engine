FactoryGirl.define do
  factory :invoice_item do
    unit_price { Faker::Number.decimal(4, 2) }
    quantity { Faker::Number.number(1) }
    item
    invoice
  end
end
