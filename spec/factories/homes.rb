# frozen_string_literal: true

FactoryBot.define do
  factory :home do
    name { Faker::Name.masculine_name }
    nw_lat { 1.5 }
    nw_long { 1.5 }
    se_lat { 1.5 }
    se_long { 1.5 }
  end
end
