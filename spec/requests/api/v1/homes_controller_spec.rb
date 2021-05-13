# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Homes', type: :request do
  include_context 'with user with homes'

  describe 'POST /api/v1/homes' do
    let(:params) do
      {
        name: Faker::Name.masculine_name,
        nw_lat: Faker::Number.between(from: -90, to: 90),
        nw_long: Faker::Number.between(from: -180, to: 180),
        se_lat: Faker::Number.between(from: -90, to: 90),
        se_long: Faker::Number.between(from: -180, to: 180)
      }
    end

    context 'when params are valid' do
      before do
        user
      end

      it 'creates a home record' do
        expect do
          post api_v1_homes_url, headers: auth_headers.merge({ 'Accept' => 'application/json' }), params: params
        end.to change(Home, :count).by(1)
      end

      it 'creates a home_users record' do
        expect do
          post api_v1_homes_url, headers: auth_headers.merge({ 'Accept' => 'application/json' }), params: params
        end.to change(HomeUser, :count).by(1)
      end
    end
  end

  describe 'GET /api/v1/homes/:id' do
    subject(:parsed_response) { JSON.parse(response.body) }

    let(:home) { create(:home) }

    context 'when ID is valid' do
      let(:response_body) do
        {
          id: home.id,
          name: home.name,
          nw_lat_long: [home.nw_lat, home.nw_long],
          se_lat_long: [home.se_lat, home.se_long],
          created_at: home.created_at,
          updated_at: home.updated_at,
          user_ids: home.users.ids
        }.to_json
      end

      it 'returns home details' do
        get api_v1_home_url(id: home.id), headers: auth_headers.merge({ 'Accept' => 'application/json' })
        expect(response.body).to eq(response_body)
      end
    end

    context 'when ID is invalid' do
      let(:response_body) do
        {
          error: 'RecordNotFound',
          message: "Couldn't find Home with 'id'=#{home.id + 10}"
        }.to_json
      end

      it 'returns error message' do
        get api_v1_home_url(id: home.id + 10), headers: auth_headers.merge({ 'Accept' => 'application/json' })
        expect(response.body).to eq(response_body)
      end
    end
  end

  describe 'GET /api/v1/homes' do
    subject(:parsed_response) { JSON.parse(response.body) }

    context 'when user has access to homes' do
      let(:user) { create(:user_with_homes, homes_count: 5) }

      it 'returns correct number of homes' do
        get api_v1_homes_url, headers: auth_headers.merge({ 'Accept' => 'application/json' })
        expect(parsed_response['data'].count).to eq(5)
      end

      it 'returns correct fields' do
        get api_v1_homes_url, headers: auth_headers.merge({ 'Accept' => 'application/json' })
        keys = %w[id name nw_lat_long se_lat_long created_at updated_at user_ids]
        expect(parsed_response['data'].first.keys).to eq(keys)
      end

      it 'returns pagination' do
        get api_v1_homes_url, headers: auth_headers.merge({ 'Accept' => 'application/json' })
        expect(parsed_response['pagination']).to eq({ 'total_pages' => 1, 'total_count' => 5, 'current_page' => 1,
                                                      'next_page' => nil })
      end
    end

    context 'when user has no homes' do
      let(:user) { create(:user) }

      it 'returns correct number of homes' do
        get api_v1_homes_url,
            headers: auth_headers.merge({ 'Accept' => 'application/json' })
        expect(parsed_response['data'].count).to eq(0)
      end
    end
  end
end
