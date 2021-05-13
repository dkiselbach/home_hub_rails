# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeUser, type: :model do
  subject(:home_user) { create(:home_user, params) }

  include_context 'with user with homes'
  let(:home) { create(:home) }
  let(:params) { { user_id: user.id, home_id: home.id } }

  describe '.valid?' do
    context 'when inputs are invalid' do
      let(:params) { { home_id: nil } }

      it { expect { home_user }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'when inputs are valid' do
      it { expect(home_user).to be_valid }
    end
  end
end
