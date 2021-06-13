# frozen_string_literal: true

module Hue
  # Class for creating a link to a local Hue Bridge
  class AddBridge
    include ActiveModel::Validations
    include ActiveModel::Callbacks

    define_model_callbacks :initialize, only: [:after]
    define_model_callbacks :create_username, only: [:after]
    after_initialize :valid?
    after_initialize :argument_error_handler
    after_create_username :response_error_handler

    attr_reader :device, :username, :ip_address
    attr_accessor :response

    validates :device, :username, :ip_address, presence: true

    def self.call(...)
      add_bridge = new(...)

      add_bridge.token
      add_bridge
    end

    def initialize(username:, device:, ip_address:)
      run_callbacks :initialize do
        @device = device
        @username = username
        @ip_address = ip_address
      end
    end

    def token
      @token ||= create_username.first['success']['username']
    end

    private

    def create_username
      run_callbacks :create_username do
        self.response = JSON.parse(Faraday.post(username_url, username_params).body)
      end
    end

    def username_params
      {
        devicetype: "home_hub##{device} #{username}"
      }
    end

    def username_url
      "https://#{ip_address}/api"
    end

    def argument_error_handler
      raise InputError.new errors.to_json, 'Hue' unless errors.empty?
    end

    def response_error_handler
      return if response.first['success']

      raise ApiError.new response.first['error']['description'], 'Hue'
    end
  end
end
