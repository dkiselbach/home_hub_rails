# frozen_string_literal: true

# A class for the Home model.
class Home < ApplicationRecord
  validates :nw_lat, :nw_long, :se_lat, :se_long, :name, presence: true
end
