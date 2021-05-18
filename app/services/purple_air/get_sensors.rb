# frozen_string_literal: true

module PurpleAir
  # Class for making requests for local sensor data from PurpleAir
  class GetSensors
    NW_LAT_LONG = [37.804930, -122.448382].freeze
    SE_LAT_LONG = [37.794832, -122.393589].freeze
    DEFAULT_FIELDS = %w[name latitude longitude altitude pm2.5 pm2.5_10minute pm2.5_30minute pm2.5_60minute
                        pm2.5_24hour].freeze
    DEFAULT_LOCATION_TYPE = %w[outside].freeze

    delegate :json_response, :parsed_response, to: :response

    def self.call
      new.request
    end

    def request
      response
      calculate_totals
      calculate_averages
      generate_getters
      self
    end

    def response
      @response ||= PurpleAirApi.client(read_token: read_token).request_sensors(fields)
    rescue StandardError => e
      raise ApiError.new e.message, 'PurpleAir'
    end

    def read_token
      ENV['READ_TOKEN']
    end

    def reading_time
      @reading_time ||= parsed_response[:time_stamp]
    end

    def fields
      {
        fields: DEFAULT_FIELDS,
        location_type: DEFAULT_LOCATION_TYPE,
        bounding_box: { nw: NW_LAT_LONG, se: SE_LAT_LONG }
      }
    end

    def calculate_averages
      count = response.parsed_response[:data].length
      instance_variables.each do |variable|
        if variable =~ /pm.*total/
          total = instance_variable_get(variable)
          instance_variable_set(variable.to_s.gsub(/total/, 'average'), (total / count).to_i)
        end
      end
    end

    def calculate_totals
      response.parsed_response[:data].each do |data_point|
        data_point_hash = data_point[1]

        data_point_hash.each do |key, value|
          next unless key =~ /pm/

          variable_name = key.gsub(/[.]/, '_')
          current_val = instance_variable_get("@#{variable_name}_total") || 0
          instance_variable_set("@#{variable_name}_total", current_val + value)
        end
      end
    end

    def generate_getters
      instance_variables.each do |variable|
        next unless variable =~ /pm/

        define_singleton_method(variable.to_s.delete('@')) { instance_variable_get variable }
      end
    end
  end
end
