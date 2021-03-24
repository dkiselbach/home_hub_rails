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

    def calculate_averages
      count = response.parsed_response[:data].length
      instance_variables.each do |variable|
        if variable =~ /pm.*total/
          total = instance_variable_get(variable)
          instance_variable_set(variable.to_s.gsub(/total/, 'average'), total / count)
        end
      end
    end

    def calculate_totals
      response.parsed_response[:data].each do |data_point|
        data_point_hash = data_point[1]

        data_point_hash.each do |key, value|
          next unless key =~ /pm/

          variable_name = key.gsub(/[.]/, 'point')
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

    # def respond_to?(method_name, *args)
    #   return true if method_name =~ /pm.*total/ || method_name =~ /pm.*average/
    #
    #   super
    # end
    #
    # def respond_to_missing?(method_name, *args)
    #   return true if method_name =~ /pm.*total/ || method_name =~ /pm.*average/
    #
    #   super
    # end
    #
    # def method_missing(method_name, *args, &block)
    #   calculate_averages if method_name =~ /average/
    #   if instance_variable_names.include? "@#{method_name}"
    #     instance_variable_get "@#{method_name}"
    #   else
    #     super
    #   end
    # end
  end
end
