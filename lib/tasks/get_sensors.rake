# frozen_string_literal: true

desc 'Query PurpleAir for sensor data and create a new database record'
task get_sensors: :environment do
  Home.all.each do |home|
    response = PurpleAir::GetSensors.call

    home.air_quality_logs.create do |log|
      log.reading_time = Time.at(response.reading_time).to_datetime.utc
      log.ten_min_average = response.pm2_5_10minute_average
      log.current_average = response.pm2_5_average
      log.thirty_min_average = response.pm2_5_30minute_average
      log.hour_average = response.pm2_5_60minute_average
      log.ten_min_average = response.pm2_5_10minute_average
      log.day_average = response.pm2_5_24hour_average
    end
  end
end
