# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  namespace :api do
    namespace :v1 do
      resources :air_quality_logs, only: %i[index]
      resources :homes do
        resources :hue
      end
    end
  end
end
