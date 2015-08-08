require 'faker'

FactoryGirl.define do
  factory :contact do
    first_name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    company
  end
end