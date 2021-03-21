class CreateAirQualityLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :air_quality_logs do |t|
      t.datetime :reading_time, null: false
      t.integer :ten_min_average
      t.integer :current_average, null: false
      t.integer :thirty_min_average
      t.integer :hour_average
      t.integer :day_average

      t.timestamps
    end
  end
end
