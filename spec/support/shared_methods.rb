# frozen_string_literal: true

RSpec.shared_context 'with user with homes', shared_context: :metadata do
  let(:user) { create(:user_with_homes) }
  let(:auth_headers) { user.create_new_auth_token.merge }
  let(:parsed_response) { JSON.parse(response.body) }
end

RSpec.shared_context 'with PurpleAir mocks', shared_context: :metadata do
  let(:home) do
    create(:home, nw_lat: params[:nwlat], nw_long: params[:nwlng], se_lat: params[:selat], se_long: params[:selng])
  end

  let(:params) do
    {
      fields: 'name,latitude,longitude,altitude,pm2.5,pm2.5_10minute,pm2.5_30minute,pm2.5_60minute,pm2.5_24hour',
      location_type: 0,
      nwlat: 37.80493,
      nwlng: -122.448382,
      selat: 37.794832,
      selng: -122.393589
    }
  end

  let(:pm2_5_values) do
    {
      pm2_5_total: 37.4,
      pm2_5_average: 2,
      pm2_5_24hour_total: 51.800000000000004,
      pm2_5_24hour_average: 3
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
end

RSpec.configure do |rspec|
  rspec.include_context 'with user with homes', include_shared: true
  rspec.include_context 'with PurpleAir mocks', include_shared: true
end
