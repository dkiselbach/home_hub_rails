# frozen_string_literal: true

# Base application controller class
class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound do |error|
    render  status: :not_found,
            json: {
              error: 'RecordNotFound',
              message: error.message
            }.to_json
  end

  include DeviseTokenAuth::Concerns::SetUserByToken
  # include ActionController::ImplicitRender
  # include ActionView::Layouts

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
