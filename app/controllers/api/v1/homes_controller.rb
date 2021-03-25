# frozen_string_literal: true

module Api
  module V1
    # A controller for interacting with the Home model
    class HomesController < ApplicationController
      before_action :authenticate_user!

      def create
        home = Home.create(params)

        raise StandardError if home.errors

        current_user.home_user.create(home_id: home.id)
      end

      def show
        Home.find(params[:id])
      end

      private

      def home_params
        params.permit(:name, :nw_lat, :nw_long, :se_lat, :se_long)
      end
    end
  end
end
