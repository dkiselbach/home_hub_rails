# frozen_string_literal: true

module Api
  module V1
    # A controller class for interacting with the Air Quality database
    class AirQualityController < ApplicationController
      def index
        render json: { hi: 'hi' }
      end
    end
  end
end
