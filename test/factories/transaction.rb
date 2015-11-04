FactoryGirl.define do
  factory :transaction do
    credit_card_number
    result
    invoice
  end
end
