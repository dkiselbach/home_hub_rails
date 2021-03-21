# frozen_string_literal: true

module Api
  module V1
    # A controller class for interacting with the Air Quality database
    class AirQualityLogsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def index
        @logs = AirQualityLog.all
      end
    end
  end
end
