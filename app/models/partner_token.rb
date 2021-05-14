# frozen_string_literal: true

class PartnerToken < ApplicationRecord
  validates :token, presence: true
  belongs_to :home
end
