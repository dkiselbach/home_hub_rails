# frozen_string_literal: true

FactoryBot.define do
  factory :home do
    name { Faker::Name.masculine_name }
    nw_lat { Faker::Number.between(from: -85, to: 85) }
    nw_long { Faker::Number.between(from: -180, to: 180) }
    se_lat { Faker::Number.between(from: -85, to: 85) }
    se_long { Faker::Number.between(from: -180, to: 180) }

    factory :home_with_token do
      transient do
        tokens_count { 1 }
      end

      after(:create) do |home, evaluator|
        evaluator.tokens_count.times do
          FactoryBot.create(:partner_token, home: home)
        end
      end
    end
  end
end
