# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }

    factory :user_with_homes do
      transient do
        homes_count { 1 }
      end

      after(:create) do |user, evaluator|
        evaluator.homes_count.times do
          user.homes << FactoryBot.create(:home)
        end
      end
    end
  end
end
