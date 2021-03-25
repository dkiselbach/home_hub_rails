class AddHomeIdToAirQualityLog < ActiveRecord::Migration[6.1]
  def change
    add_reference :air_quality_logs, :homes, null: false, foreign_key: true
  end
end
