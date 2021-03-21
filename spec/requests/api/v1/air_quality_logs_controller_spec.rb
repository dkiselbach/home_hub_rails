# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AirQualityLogsController, type: :request do
  include_context 'with shared methods'

  before do
    create_list(:air_quality_log, 5)
  end

  describe '#index' do
    subject(:parsed_response) { JSON.parse(response.body) }

    it 'returns correct number of records' do
      get '/api/v1/air_quality_logs', headers: auth_headers.merge({ 'Accept' => 'application/json' })
      expect(parsed_response.length).to eq(5)
    end

    it 'returns correct fields' do
      get '/api/v1/air_quality_logs', headers: auth_headers.merge({ 'Accept' => 'application/json' })
      expect(parsed_response.first.keys).to eq(%w[id created_at reading_time])
    end

    it 'returns error if no auth given' do
      get '/api/v1/air_quality_logs'
      expect(response.status).to eq(401)
    end
  end
end
