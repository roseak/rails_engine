FactoryGirl.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(16) }
    result "success"
    invoice
  end
end
