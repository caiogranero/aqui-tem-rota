class CreateGtfsEngineFrequencies < ActiveRecord::Migration[5.1]
  TABLE = :gtfs_engine_frequencies

  def change
    create_table TABLE do |t|
      t.string  :trip_id,       null: false
      t.string  :start_time,   null: false
      t.string  :end_time,     null: false
      t.integer :headway_secs,  null: false
    end

    add_index TABLE, :trip_id
  end
end
