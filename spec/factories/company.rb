require 'faker'

FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    type_company { TypeCompany::COMPANY }
    status { StatusCompany::ON_HOLD }
    category

    factory :company_with_payments do
      transient do
        payments_count 2
      end
      after(:build) do |company, evaluator|
        create_list(:payment, evaluator.payments_count, company: company)
      end
    end

    factory :company_with_profile_complete do
      description { Faker::Lorem.paragraph }
      tax_id { Faker::PhoneNumber.phone_number }
      address { Faker::Lorem.word }
      logo { Faker::Company.logo }
      website { Faker::Internet.url }
      complete_profile { true }

      factory :company_complete_with_payment do
         transient do
          payments_count 2
        end
        after(:build) do |company, evaluator|
          create_list(:payment, evaluator.payments_count, company: company)
        end
      end
    end
  end
end