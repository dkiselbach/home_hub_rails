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
        ipAddress: '101.101.46.21',
        homeId: user.homes.first.id
      }
    end

    context 'when Hue Bridge is available and button is pressed' do
      let(:success_response) do
        {
          message: 'Hue token created successfully'
        }.to_json
      end

      it 'creates a token' do
        expect { create_hue }.to change(PartnerToken, :count).by(1)
      end

      it 'returns newly created token' do
        create_hue
        expect(response.body).to eq(success_response)
      end

      it 'returns success code' do
        create_hue

        expect(response.status).to eq(201)
      end
    end

    context 'when home_id is invalid' do
      before do
        params[:homeId] = user.homes.last.id + 10
      end

      let(:error_response) do
        {
          error: 'RecordNotFound',
          message: 'User does not have access to the home, or the home_id provided is invalid.'
        }.to_json
      end

      it 'does not create token' do
        expect { create_hue }.to change(PartnerToken, :count).by(0)
      end

      it 'returns error message' do
        create_hue

        expect(response.body).to eq(error_response)
      end

      it 'returns error code' do
        create_hue

        expect(response.status).to eq(404)
      end
    end

    context 'when Hue API returns an error' do
      # let(:add_bridge) { instance_double('Hue::AddBridge') }
      let(:error_response) do
        {
          error: 'ApiError',
          api: 'Hue',
          message: 'link button not pressed'
        }.to_json
      end

      before do
        stub_request(:post, 'https://101.101.46.21/api')
          .with(
            body: username_params
          )
          .to_return(status: 200, body: WebmockHelper.response_body('hue/errors/link_button_not_pressed.json'))

        create_hue
      end

      it 'returns error description' do
        expect(response.body).to eq(error_response)
      end
    end
  end
end
