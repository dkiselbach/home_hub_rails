# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurpleAir::GetSensors do
  include_context 'with PurpleAir mocks'

  describe '.call' do
    it 'makes a request to PurpleAirApi' do
      expect(described_class.call.parsed_response[:data].length).to eq(17)
    end
  end
end
