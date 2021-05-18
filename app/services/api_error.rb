# A base class for API errors
class ApiError < StandardError
  attr_reader :api

  def initialize(message, api = nil)
    @api = api
    super(message)
  end
end
