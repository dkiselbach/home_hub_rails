# frozen_string_literal: true

# A class for the Home User relationship model
class HomeUser < ApplicationRecord
  belongs_to :user
  belongs_to :home
end
