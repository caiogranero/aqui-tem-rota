# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170602230042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "gtfs_engine_agencies", force: :cascade do |t|
    t.string "agency_id"
    t.string "agency_name", null: false
    t.string "agency_url", null: false
    t.string "agency_timezone", null: false
    t.string "agency_lang"
    t.index ["agency_id"], name: "index_gtfs_engine_agencies_on_agency_id"
  end

  create_table "gtfs_engine_calendars", force: :cascade do |t|
    t.string "service_id", null: false
    t.boolean "monday", null: false
    t.boolean "tuesday", null: false
    t.boolean "wednesday", null: false
    t.boolean "thursday", null: false
    t.boolean "friday", null: false
    t.boolean "saturday", null: false
    t.boolean "sunday", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.index ["end_date"], name: "index_gtfs_engine_calendars_on_end_date"
    t.index ["service_id"], name: "index_gtfs_engine_calendars_on_service_id"
    t.index ["start_date"], name: "index_gtfs_engine_calendars_on_start_date"
  end

  create_table "gtfs_engine_fare_attributes", force: :cascade do |t|
    t.string "fare_id", null: false
    t.float "price", null: false
    t.string "currency_type", null: false
    t.integer "payment_method", null: false
    t.string "transfers"
    t.integer "transfer_duration"
    t.index ["fare_id"], name: "index_gtfs_engine_fare_attributes_on_fare_id"
  end

  create_table "gtfs_engine_fare_rules", force: :cascade do |t|
    t.string "fare_id", null: false
    t.string "route_id"
    t.string "origin_id"
    t.string "destination_id"
    t.string "contains_id"
    t.index ["fare_id"], name: "index_gtfs_engine_fare_rules_on_fare_id"
  end

  create_table "gtfs_engine_frequencies", force: :cascade do |t|
    t.string "trip_id", null: false
    t.string "start_time", null: false
    t.string "end_time", null: false
    t.integer "headway_secs", null: false
    t.index ["trip_id"], name: "index_gtfs_engine_frequencies_on_trip_id"
  end

  create_table "gtfs_engine_routes", force: :cascade do |t|
    t.string "route_id", null: false
    t.string "agency_id"
    t.string "route_short_name", null: false
    t.string "route_long_name", null: false
    t.integer "route_type", null: false
    t.string "route_color"
    t.string "route_text_color"
    t.index ["route_id"], name: "index_gtfs_engine_routes_on_route_id"
    t.index ["route_short_name"], name: "index_gtfs_engine_routes_on_route_short_name"
  end

  create_table "gtfs_engine_shapes", force: :cascade do |t|
    t.string "shape_id", null: false
    t.geometry "shape_pt_point", limit: {:srid=>0, :type=>"st_point"}
    t.float "shape_pt_lon", null: false
    t.float "shape_pt_lat", null: false
    t.integer "shape_pt_sequence", null: false
    t.float "shape_dist_traveled"
    t.index ["shape_id"], name: "index_gtfs_engine_shapes_on_shape_id"
    t.index ["shape_pt_lat"], name: "index_gtfs_engine_shapes_on_shape_pt_lat"
    t.index ["shape_pt_lon"], name: "index_gtfs_engine_shapes_on_shape_pt_lon"
    t.index ["shape_pt_point"], name: "index_gtfs_engine_shapes_on_shape_pt_point"
    t.index ["shape_pt_sequence"], name: "index_gtfs_engine_shapes_on_shape_pt_sequence"
  end

  create_table "gtfs_engine_stop_times", force: :cascade do |t|
    t.string "stop_id", null: false
    t.string "trip_id", null: false
    t.string "arrival_time", null: false
    t.string "departure_time", null: false
    t.integer "stop_sequence", null: false
    t.index ["arrival_time"], name: "index_gtfs_engine_stop_times_on_arrival_time"
    t.index ["departure_time"], name: "index_gtfs_engine_stop_times_on_departure_time"
    t.index ["stop_id"], name: "index_gtfs_engine_stop_times_on_stop_id"
    t.index ["trip_id"], name: "index_gtfs_engine_stop_times_on_trip_id"
  end

  create_table "gtfs_engine_stops", force: :cascade do |t|
    t.string "stop_id", null: false
    t.string "stop_name", null: false
    t.string "stop_desc"
    t.geometry "stop_point", limit: {:srid=>0, :type=>"st_point"}
    t.float "stop_lat", null: false
    t.float "stop_lon", null: false
    t.index ["stop_id"], name: "index_gtfs_engine_stops_on_stop_id"
    t.index ["stop_lat"], name: "index_gtfs_engine_stops_on_stop_lat"
    t.index ["stop_lon"], name: "index_gtfs_engine_stops_on_stop_lon"
    t.index ["stop_point"], name: "index_gtfs_engine_stops_on_stop_point"
  end

  create_table "gtfs_engine_trips", force: :cascade do |t|
    t.string "route_id", null: false
    t.string "service_id", null: false
    t.string "trip_id", null: false
    t.string "shape_id", null: false
    t.string "trip_headsign"
    t.integer "direction_id"
    t.index ["route_id"], name: "index_gtfs_engine_trips_on_route_id"
    t.index ["shape_id"], name: "index_gtfs_engine_trips_on_shape_id"
    t.index ["trip_id"], name: "index_gtfs_engine_trips_on_trip_id"
  end

end
