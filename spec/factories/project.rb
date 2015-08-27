require 'faker'

FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    timeframes { Time.now.utc }
    company
    after(:create) {|project| project.skills = [create(:skill)]}

    factory :project_invalid do
      name { nil }
    end
  end
end