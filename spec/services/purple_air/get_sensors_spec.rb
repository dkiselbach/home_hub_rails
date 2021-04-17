# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurpleAir::GetSensors do
  subject(:get_sensors) { described_class.call }

  include_context 'with PurpleAir mocks'

  describe '.call' do
    it 'makes a request to PurpleAirApi' do
      expect(get_sensors.parsed_response[:data].length).to eq(17)
    end

    %i[@pm2_5_total @pm2_5_average @pm2_5_24hour_total @pm2_5_24hour_average].each do |instance_variable|
      it "sets the correct value for #{instance_variable}" do
        value = pm2_5_values[instance_variable.to_s.delete('@').to_sym]
        expect(get_sensors.instance_variable_get(instance_variable)).to eq(value)
      end
    end
  end
end
