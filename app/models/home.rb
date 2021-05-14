# frozen_string_literal: true

# A class for the Home model.
class Home < ApplicationRecord
  validates :name, presence: true
  validates :nw_lat, :se_lat, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :nw_long, :se_long, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  has_many :air_quality_logs, dependent: :destroy
  has_many :home_users, dependent: :destroy
  has_many :users, through: :home_users
  has_many :partner_tokens, dependent: :destroy
end
