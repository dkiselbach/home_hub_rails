# frozen_string_literal: true

FactoryBot.define do
  factory :partner_token do
    token { Faker::Internet.uuid }
    home
  end
end
