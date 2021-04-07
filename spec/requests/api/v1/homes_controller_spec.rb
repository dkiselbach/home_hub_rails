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
        se_long: Faker::Number.between(from: -180, to: 180),
      }
    end

    context "when params are valid" do
      it 'creates a home record' do
        expect do
          post '/api/v1/homes', headers: auth_headers.merge({ 'Accept' => 'application/json' }), params: params
        end.to change(Home, :count).by(1)
      end
      
      it 'creates a home_users record' do
        expect do
          post '/api/v1/homes', headers: auth_headers.merge({ 'Accept' => 'application/json' }), params: params
        end.to change(HomeUser,  :count).by(1)
      end
    end
  end

  describe 'GET /api/v1/homes/:id' do
    subject(:parsed_response) { JSON.parse(response.body) }

    let(:home) { create(:home) }

    context 'when ID is valid' do
      it 'returns home details' do
        get '/api/v1/homes/' + home.id.to_s, headers: auth_headers.merge({ 'Accept' => 'application/json' })
        binding.irb
        expect(parsed_response['pagination']).to eq({ 'total_pages' => 1, 'total_count' => 5, 'current_page' => 1,
                                                      'next_page' => nil })

      end
    end

  end
end
