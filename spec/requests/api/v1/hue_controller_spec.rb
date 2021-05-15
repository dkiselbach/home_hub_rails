# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Hue', type: :request do
  include_context 'with user with homes'
  include_context 'with Hue mocks'

  describe 'POST /api/v1/hue' do
    subject(:create_hue) do
      post api_v1_hue_index_url, headers: auth_headers.merge({ 'Accept' => 'application/json' }), params: params
    end

    let(:params) do
      {
        username: 'dylan',
        device: 'iphone',
        ip_address: '101.101.46.21',
        home_id: user.homes.first.id
      }
    end

    context 'when Hue Bridge is available and button is pressed' do
      it 'creates a token' do
        expect { create_hue }.to change(PartnerToken, :count).by(1)
      end
    end
  end
end
