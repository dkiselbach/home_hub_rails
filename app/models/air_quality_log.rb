# frozen_string_literal: true

class AirQualityLog < ApplicationRecord
  validates :reading_time, presence: true
  validates :home_id, presence: true
  validates :ten_min_average, numericality: { only_integer: true }
  validates :current_average, presence: true, numericality: { only_integer: true }
  validates :thirty_min_average, numericality: { only_integer: true }
  validates :hour_average, numericality: { only_integer: true }
  validates :day_average, numericality: { only_integer: true }

  belongs_to :home
end
