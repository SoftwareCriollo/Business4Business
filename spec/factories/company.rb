require 'faker'

FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    type { TypeCompany::COMPANY }
    status { StatusCompany::ON_HOLD }
    contact_name { Faker::Lorem.word }
    category

    factory :team_company do
      type { TypeCompany::TEAM_COMPANY }
    end

    factory :company_with_payments do
      transient do
        payments_count 2
      end
      after(:build) do |company, evaluator|
        create_list(:payment, evaluator.payments_count, company: company)
      end

      after(:create) do |company, evaluator|
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

        after(:create) do |company, evaluator|
          create_list(:payment, evaluator.payments_count, company: company)
        end

        factory :company_approve_with_payment do
          status { StatusCompany::APPROVE }
        end
      end
    end
  end
end