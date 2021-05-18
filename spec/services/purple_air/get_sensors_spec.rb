# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurpleAir::GetSensors do
  subject(:get_sensors) { described_class.call }

  include_context 'with PurpleAir mocks'

  describe '.call' do
    context 'when request is successful' do
      it 'makes a request to PurpleAirApi' do
        expect(get_sensors.parsed_response[:data].length).to eq(17)
      end

      %i[@pm2_5_total @pm2_5_average @pm2_5_24hour_total @pm2_5_24hour_average].each do |instance_variable|
        it "sets the correct value for #{instance_variable}" do
          value = pm2_5_values[instance_variable.to_s.delete('@').to_sym]
          expect(get_sensors.instance_variable_get(instance_variable)).to eq(value)
        end
      end
    end

    context 'when PurpleAir gem raises an exception' do
      before do
        stub_request(:get, 'https://api.purpleair.com/v1/sensors')
          .with(
            query: params,
            headers: {
              'X-Api-Key' => ENV['READ_TOKEN']
            }
          )
          .to_return(status: 403, body: WebmockHelper.response_body('purple_air/errors/api_key_invalid_token.json'))
      end

      it 'raises an API Error' do
        aggregate_failures do
          expect { get_sensors }.to raise_error(ApiError, 'The provided token was not valid.') do |error|
            expect(error.api).to eq('PurpleAir')
          end
        end
      end
    end
  end
end
