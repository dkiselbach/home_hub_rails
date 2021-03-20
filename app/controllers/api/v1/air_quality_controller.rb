# frozen_string_literal: true

module Api
  module V1
    # A controller class for interacting with the Air Quality database
    class AirQualityController < ApplicationController
      before_action :authenticate_api_v1_user!

      def index
        render json: { hi: 'hi' }
      end
    end
  end
end
