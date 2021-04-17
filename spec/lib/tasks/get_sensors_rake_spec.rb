# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'test_get_sensors' do
  subject(:get_sensors) { Rake::Task['get_sensors'].invoke }

  include_context 'with PurpleAir mocks'

  context 'when home exists' do
    it 'creates an air_quality log' do
      home
      expect { get_sensors }.to change(AirQualityLog, :count).by(1)
    end
  end

  context 'when home does not exist' do
    it 'does nothing' do
      expect { get_sensors }.not_to change(AirQualityLog, :count)
    end
  end
end
