# frozen_string_literal: true

json.array! @logs do |log|
  json.id log.id
  json.created_at log.created_at
  json.reading_time log.reading_time
end
