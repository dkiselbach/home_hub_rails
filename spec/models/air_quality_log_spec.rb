# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AirQualityLog, type: :model do
  describe '.valid?' do
    context 'when all fields are valid' do
      let(:air_quality_log) { create(:air_quality_log) }

      it 'creates an air quality log' do
        expect { air_quality_log }.to change(described_class, :count).by(1)
      end
    end

    context 'when fields are missing' do
      let(:air_quality_log) { create(:air_quality_log, current_average: nil) }

      it 'raises validation error' do
        expect { air_quality_log }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
