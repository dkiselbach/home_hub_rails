# frozen_string_literal: true

module Api
  module V1
    # A controller class for interacting with the Air Quality database
    class AirQualityLogsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def index
        page = params[:page] || 1
        per = params[:per] || 25
        fields = ['homes.*', 'air_quality_logs.*', 'air_quality_logs.id as air_quality_log_id', 'users.id as user_id']
        @logs = User.joins(homes: :air_quality_logs).select(*fields).page(page).per(per)
      end
    end
  end
end
