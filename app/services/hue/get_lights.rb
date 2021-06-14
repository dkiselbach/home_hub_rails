# frozen_string_literal: true

module Hue
  # Class for getting light information from Hue
  class GetLights
    include ActiveModel::Validations
    include ActiveModel::Callbacks

    define_model_callbacks :initialize, only: [:after]
    define_model_callbacks :request, only: [:after]
    after_initialize :valid?
    after_initialize :argument_error_handler
    after_request :response_error_handler

    attr_reader :token, :ip_address
    attr_accessor :response

    validates :token, :ip_address, presence: true

    def self.call(...)
      new(...).request
    end

    def initialize(token:, ip_address:)
      run_callbacks :initialize do
        @token = token
        @ip_address = ip_address
      end
    end

    def request
      run_callbacks :request do
        self.response = JSON.parse(Faraday.get(url).body)
      end
    end

    private

    def url
      "http://#{ip_address}/api/#{token}/lights"
    end

    def argument_error_handler
      raise InputError.new errors.to_json, 'Hue' unless errors.empty?
    end

    def response_error_handler
      return if response.first.instance_of?(Array)
      raise ApiError.new response.first['error']['description'], 'Hue' if response.first['error']

      raise StandardError, response
    end
  end
end
