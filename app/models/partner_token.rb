# frozen_string_literal: true

class PartnerToken < ApplicationRecord
  validates :token, presence: true
  validates :ip_address, presence: true
  belongs_to :home
end
