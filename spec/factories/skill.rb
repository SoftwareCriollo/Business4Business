require 'faker'

FactoryGirl.define do
  factory :skill do
    name { Faker::Lorem.word }

    factory :skill_invalid do
      name { }
    end
  end
end