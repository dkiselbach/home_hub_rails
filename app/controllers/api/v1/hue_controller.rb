# frozen_string_literal: true

module Api
  module V1
    # A controller for interacting with the Hue API
    class HueController < ApplicationController
      before_action :authenticate_user!
      before_action only: [:create] do
        if current_user.homes.where(id: params[:homeId]).empty?
          raise ActiveRecord::RecordNotFound,
                'User does not have access to the home, or the home_id provided is invalid.'

        end
      end

      def create
        token = Hue::AddBridge.call(username: params[:username], device: params[:device],
                                    ip_address: params[:ipAddress]).token

        PartnerToken.create(token: token, home_id: params[:homeId])

        render status: :created,
               json: {
                 message: 'Hue token created successfully'
               }.to_json
      end
    end
  end
end
