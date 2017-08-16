class CreateGtfsEngineShapes < ActiveRecord::Migration[5.1]
  TABLE = :gtfs_engine_shapes

  def change
    create_table TABLE do |t|
      t.string  :shape_id,            null: false
      t.st_point   :shape_pt_point
      t.float   :shape_pt_lon,        null: false
      t.float   :shape_pt_lat,        null: false
      t.integer :shape_pt_sequence,   null: false
      t.float   :shape_dist_traveled
    end

    add_index TABLE, :shape_id
    add_index TABLE, :shape_pt_sequence
    add_index TABLE, :shape_pt_point
    add_index TABLE, :shape_pt_lon
    add_index TABLE, :shape_pt_lat
  end
end
