# frozen_string_literal: true

# A class for the Home model.
class Home < ApplicationRecord
  validates :nw_lat, :nw_long, :se_lat, :se_long, :name, presence: true

  has_many :air_quality_logs, dependent: :destroy
  has_many :home_users, dependent: :destroy
  has_many :users, through: :home_users
end
