# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AirQualityController, type: :request do
  include_context 'with shared methods'

  describe '#index' do
    it 'returns hi' do
      get '/api/v1/air_quality', headers: auth_headers
      expect(response.body).to include('hi')
    end

    it 'returns error if no auth given' do
      get '/api/v1/air_quality'
      expect(response.status).to eq(401)
    end
  end
end
