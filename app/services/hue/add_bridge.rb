# frozen_string_literal: true

module Hue
  # Class for creating a link to a local Hue Bridge
  class AddBridge
    attr_reader :device, :username, :ip_address

    def self.call(...)
      new(...).execute
    end

    def initialize(username:, device:, ip_address:)
      @device = device
      @username = username
      @ip_address = ip_address
    end

    def execute
      token
      self
    end

    def token
      @token ||= create_username.first['success']['username']
    end

    private

    def create_username
      response = JSON.parse(Faraday.post(username_url, username_params).body)

      return response if response.first['success']

      raise ApiError.new response.first['error']['description'], 'Hue'
    end

    def username_params
      {
        devicetype: "home_hub##{device} #{username}"
      }
    end

    def username_url
      "https://#{ip_address}/api"
    end
  end
end
