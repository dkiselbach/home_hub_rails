# frozen_string_literal: true

# Base application controller class
class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  include DeviseTokenAuth::Concerns::SetUserByToken
  # include ActionController::ImplicitRender
  # include ActionView::Layouts

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
