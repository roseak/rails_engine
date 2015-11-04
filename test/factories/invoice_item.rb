FactoryGirl.define do
  factory :invoice_item do
    unit_price
    quantity
    item
    invoice
  end
end
