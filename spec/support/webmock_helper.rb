# frozen_string_literal: true

module WebmockHelper
  def self.response_body(path)
    pathname = File.join(%w[spec webmocks services], path)
    File.read(pathname)
  end
end
