# frozen_string_literal: true

# A class for the Home User relationship model
class HomeUser < ApplicationRecord
  validates :user_id, presence: true
  validates :home_id, presence: true
  belongs_to :user
  belongs_to :home
end
