# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Homes', type: :request do
  include_context 'with shared methods'

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
      it 'creates a home record' do
        expect do
          post '/api/v1/homes', headers: auth_headers.merge({ 'Accept' => 'application/json' }), params: params
        end.to change(Home, :count).by(1)
      end

      it 'creates a home_users record' do
        expect do
          post '/api/v1/homes', headers: auth_headers.merge({ 'Accept' => 'application/json' }), params: params
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
        get "/api/v1/homes/#{home.id}", headers: auth_headers.merge({ 'Accept' => 'application/json' })
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
        get "/api/v1/homes/#{home.id + 10}", headers: auth_headers.merge({ 'Accept' => 'application/json' })
        expect(response.body).to eq(response_body)
      end
    end
  end
end
