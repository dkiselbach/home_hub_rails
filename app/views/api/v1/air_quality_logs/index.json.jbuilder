# frozen_string_literal: true

json.partial! 'api/v1/pagination', collection: @logs

json.data @logs do |log|
  json.id log.air_quality_log_id
  json.user_id log.user_id
  json.home_name log.name
  json.home_id log.home_id
  json.home_region_nw_lat_long [log.nw_lat, log.nw_long]
  json.home_region_se_lat_long [log.se_lat, log.se_long]
  json.reading_time log.reading_time
  json.current_average log.current_average
  json.ten_min_average log.ten_min_average
  json.thirty_min_average log.thirty_min_average
  json.hour_average log.hour_average
  json.day_average log.day_average
end
