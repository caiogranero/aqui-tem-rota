class CreateGtfsEngineStops < ActiveRecord::Migration[5.1]
  TABLE = :gtfs_engine_stops

  def change
    create_table TABLE do |t|
      t.string      :stop_id,         null: false
      t.string      :stop_name,       null: false
      t.string      :stop_desc
      t.st_point    :stop_point
      t.float       :stop_lat,            null: false
      t.float       :stop_lon,            null: false

    end

    add_index TABLE, :stop_id
    add_index TABLE, :stop_point
    add_index TABLE, :stop_lon
    add_index TABLE, :stop_lat
  end
end
