# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hue::AddBridge do
  subject(:add_bridge) { described_class.call(username: 'dylan', device: 'iphone', ip_address: '101.101.46.21') }

  include_context 'with Hue mocks'

  describe '.call' do
    context 'when link button is pressed' do
      it 'creates a new username for the bridge' do
        expect(add_bridge.token).to eq('DP-54FR3bze5KFV1rn43dyeF9a69xe-G8-6ZB12')
      end
    end

    context 'when link button is not pressed' do
      before do
        stub_request(:post, 'https://101.101.46.21/api')
          .with(
            body: username_params
          )
          .to_return(status: 200, body: WebmockHelper.response_body('hue/errors/link_button_not_pressed.json'))
      end

      it 'raises an error' do
        aggregate_failures do
          expect { add_bridge }.to raise_error(ApiError, 'link button not pressed') do |error|
            expect(error.api).to eq('Hue')
          end
        end
      end
    end

    context 'when params are nil' do
      subject(:add_bridge) { described_class.call(username: 'dylan', device: 'iphone', ip_address: nil) }

      it 'raises error' do
        expect { add_bridge }.to raise_error(InputError)
      end
    end
  end
end
