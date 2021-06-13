# frozen_string_literal: true

# A base class for API errors
class InputError < StandardError
  attr_reader :api

  def initialize(message, api = nil)
    @api = api
    super(message)
  end
end
