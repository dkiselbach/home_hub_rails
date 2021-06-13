# frozen_string_literal: true

FactoryBot.define do
  factory :partner_token do
    token { Faker::Internet.uuid }
    ip_address { Faker::Internet.ip_v4_address }
    home
  end
end
