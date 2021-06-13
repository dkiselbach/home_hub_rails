# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PartnerToken, type: :model do
  it 'token is created successfully' do
    token = described_class.create(token: Faker::Internet.uuid, home: create(:home),
                                   ip_address: Faker::Internet.ip_v4_address)
    expect(token).to be_valid
  end

  it 'validates presence of token' do
    expect(described_class.create(home: create(:home), ip_address: Faker::Internet.ip_v4_address)).not_to be_valid
  end

  it 'validates presence of ip_address' do
    expect(described_class.create(home: create(:home), token: Faker::Internet.uuid)).not_to be_valid
  end
end
