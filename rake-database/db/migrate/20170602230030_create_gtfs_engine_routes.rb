class CreateGtfsEngineRoutes < ActiveRecord::Migration[5.1]
  TABLE = :gtfs_engine_routes

  def change
    create_table TABLE do |t|
      t.string  :route_id,         null: false
      t.string  :agency_id
      t.string  :route_short_name, null: false
      t.string  :route_long_name,  null: false
      t.integer :route_type,       null: false
      t.string  :route_color
      t.string  :route_text_color
    end

    add_index TABLE, :route_id
    add_index TABLE, :route_short_name
  end
end
