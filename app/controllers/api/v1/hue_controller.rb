# frozen_string_literal: true

module Api
  module V1
    # A controller for interacting with the Hue API
    class HueController < ApplicationController
      before_action :authenticate_user!

      def create
        if current_user.homes.where(id: params[:home_id]).empty?
          render json: {
            error: 'Home is invalid'
          }.to_json
        end

        token = Hue::AddBridge.call(username: params[:username], device: params[:device],
                                    ip_address: params[:ip_address]).token

        PartnerToken.create(token: token, home_id: params[:home_id])
      end
    end
  end
end
