class CreateGtfsEngineTrips < ActiveRecord::Migration[5.1]
  TABLE = :gtfs_engine_trips

  def change
    create_table TABLE do |t|
      t.string  :route_id,              null: false
      t.string  :service_id,            null: false
      t.string  :trip_id,               null: false
      t.string  :shape_id,              null: false
      t.string  :trip_headsign
      t.integer :direction_id
    end

    add_index TABLE, :trip_id
    add_index TABLE, :route_id
    add_index TABLE, :shape_id
  end
end
