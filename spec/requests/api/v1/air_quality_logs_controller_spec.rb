# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AirQualityLogsController, type: :request do
  include_context 'with shared methods'

  before do
    home = create(:home)
    create_list(:air_quality_log, 5, home: home)
    create(:home_user, user_id: user.id, home_id: home.id)
  end

  describe '#index' do
    subject(:parsed_response) { JSON.parse(response.body) }

    it 'returns correct number of records' do
      get '/api/v1/air_quality_logs', headers: auth_headers.merge({ 'Accept' => 'application/json' })
      expect(parsed_response['data'].length).to eq(5)
    end

    it 'returns correct fields' do
      get '/api/v1/air_quality_logs', headers: auth_headers.merge({ 'Accept' => 'application/json' })
      keys = %w[id user_id home_name home_id home_region_nw_lat_long home_region_se_lat_long
                reading_time current_average ten_min_average thirty_min_average hour_average day_average]
      expect(parsed_response['data'].first.keys).to eq(keys)
    end

    it 'returns pagination' do
      get '/api/v1/air_quality_logs', headers: auth_headers.merge({ 'Accept' => 'application/json' })
      expect(parsed_response['pagination']).to eq({ 'total_pages' => 1, 'total_count' => 5, 'current_page' => 1,
                                                    'next_page' => nil })
    end

    it 'returns error if no auth given' do
      get '/api/v1/air_quality_logs'
      expect(response.status).to eq(401)
    end
  end
end
