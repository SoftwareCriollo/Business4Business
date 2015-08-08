require 'faker'

FactoryGirl.define do
  factory :payment do
    company
    amount { Faker::Number.decimal(2, 2) }

    factory :payment_expired do
      created_at { 2.year.ago }
    end
  end
end