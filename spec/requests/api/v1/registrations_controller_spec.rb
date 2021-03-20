# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeviseTokenAuth::RegistrationsController', type: :request do
  context 'when using permitted params' do
    let(:headers) { { 'Content-Type' => 'application/json', 'Accept' => 'application/json' } }
    let(:params) do
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end
    let(:create_user_request) { post '/api/v1/auth', params: params, headers: headers }

    it 'user is added to database' do
      expect { create_user_request }.to change(User, :count).by(1)
    end

    it '200 response code is returned' do
      create_user_request
      expect(response).to have_http_status(:success)
    end

    it 'user has a name' do
      create_user_request
      expect(User.last.name).not_to be_nil
    end
  end
end
