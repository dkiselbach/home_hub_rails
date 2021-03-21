# frozen_string_literal: true

module PurpleAir
  # Class for making requests for local sensor data from PurpleAir
  class GetSensors
    NW_LAT_LONG = [37.804930, -122.448382].freeze
    SE_LAT_LONG = [37.794832, -122.393589].freeze
    DEFAULT_FIELDS = %w[icon name latitude longitude altitude pm2.5 pm2.5_10minute pm2.5_30minute pm2.5_60minute
                        pm2.5_24hour].freeze
    DEFAULT_LOCATION_TYPE = %w[outside].freeze

    def self.call
      new.request
    end

    def request
      @request ||= PurpleAirApi.client(read_token: read_token).request_sensors(fields)
    end

    def read_token
      ENV['READ_TOKEN']
    end

    def fields
      {
        fields: DEFAULT_FIELDS,
        location_type: DEFAULT_LOCATION_TYPE,
        bounding_box: { nw: NW_LAT_LONG, se: SE_LAT_LONG }
      }
    end

    # def calculate_averages
    #   request.json_response[:data]
    # end
  end
end
