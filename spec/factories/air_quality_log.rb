# frozen_string_literal: true

FactoryBot.define do
  factory :air_quality_log do
    reading_time { Time.now.utc }
    current_average { Faker::Number.between(from: 0, to: 100) }
    ten_min_average { Faker::Number.between(from: 0, to: 100) }
    thirty_min_average { Faker::Number.between(from: 0, to: 100) }
    hour_average { Faker::Number.between(from: 0, to: 100) }
    day_average { Faker::Number.between(from: 0, to: 100) }
    home
  end
end
