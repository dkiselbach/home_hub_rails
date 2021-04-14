# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Home, type: :model do
  subject(:home) { create(:home, params) }

  let(:params) { { se_lat: 80, se_long: 60 } }

  describe '.valid?' do
    context 'when inputs are valid' do
      it { expect { home }.to change(described_class, :count) }
    end

    context 'when inputs are invalid' do
      let(:params) { { se_lat: -200, se_long: '2000' } }

      it { expect { home }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end

  describe 'dependent: :destroy' do
    context 'when home has air_quality_log' do
      before do
        create(:air_quality_log, home: home)
      end

      it 'destroys air_quality_log' do
        expect { home.destroy }.to change(AirQualityLog, :count).by(-1)
      end
    end

    context 'when home has home_users' do
      before do
        user = create(:user)
        create(:home_user, home: home, user: user)
      end

      it 'destroys home_users' do
        expect { home.destroy }.to change(HomeUser, :count).by(-1)
      end
    end
  end
end
