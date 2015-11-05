FactoryGirl.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(16) }
    # credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result "success"
    invoice
  end
end
