# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hue::GetLights do
  subject(:get_lights) { described_class.call(ip_address: '101.101.46.21', token: token) }

  let(:token) { 'valid_token' }

  include_context 'with Hue mocks'

  describe '.call' do
    context 'when authorization is valid' do
      it 'returns lights' do
        aggregate_failures do
          expect(get_lights.length).to eq(5)
          expect(get_lights.first[0]).to eq('9')
          expect(get_lights['12']['state']['on']).to be_falsey
        end
      end
    end

    context 'when authorization is invalid' do
      let(:token) { 'invalid_token' }

      it 'raises an error' do
        aggregate_failures do
          expect { get_lights }.to raise_error(ApiError, 'unauthorized user') do |error|
            expect(error.api).to eq('Hue')
          end
        end
      end
    end

    context 'when params are nil' do
      let(:token) { nil }

      it 'raises error' do
        expect { get_lights }.to raise_error(InputError)
      end
    end
  end
end
