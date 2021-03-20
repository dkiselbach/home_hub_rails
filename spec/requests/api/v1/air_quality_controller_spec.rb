# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AirQualityController, type: :request do
  it 'returns hi' do
    get '/api/v1/air_quality'
  end
end
