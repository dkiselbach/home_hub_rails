# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurpleAir::GetSensors, type: :model do
  let(:params) do
    {
      fields: 'icon,name,latitude,longitude,altitude,pm2.5,pm2.5_10minute,pm2.5_30minute,pm2.5_60minute,pm2.5_24hour',
      location_type: 0,
      nwlat: 37.80493,
      nwlng: -122.448382,
      selat: 37.794832,
      selng: -122.393589
    }
  end

  before do
    stub_request(:get, 'https://api.purpleair.com/v1/sensors')
      .with(
        query: params,
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.3.0',
          'X-Api-Key' => ENV['READ_TOKEN']
        }
      )
      .to_return(status: 200, body: WebmockHelper.response_body('get_sensors.json'), headers: {})
  end

  describe '.call' do
    it 'makes a request to PurpleAirApi' do
      expect(described_class.call.parsed_response[:data].length).to eq(17)
    end
  end
end
