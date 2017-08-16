class CreateGtfsEngineStopTimes < ActiveRecord::Migration[5.1]
  TABLE = :gtfs_engine_stop_times

  def change
    create_table TABLE do |t|
      t.string  :stop_id,             null: false
      t.string  :trip_id,             null: false
      t.string  :arrival_time,        null: false
      t.string  :departure_time,      null: false
      t.integer :stop_sequence,       null: false
    end

    add_index TABLE, :stop_id
    add_index TABLE, :trip_id
    add_index TABLE, :arrival_time
    add_index TABLE, :departure_time
  end
end
