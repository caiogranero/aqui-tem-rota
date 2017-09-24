const Database = require('../helpers/Database')
const pp = require('preprocess')

const Map = {
  get (params) {
    const query =
            `
            SELECT 
                SHAPES.shape_id,    
                SHAPES.shape_pt_lon,
                SHAPES.shape_pt_lat,
                TRIPS.trip_headsign,
                ROUTES.route_id,
                STOPS.stop_name,
                STOPS.stop_lat,
                STOPS.stop_lon,
                STOPS.stop_id
            FROM gtfs_engine_shapes AS SHAPES
            INNER JOIN gtfs_engine_trips AS TRIPS ON SHAPES.shape_id = TRIPS.shape_id
            INNER JOIN gtfs_engine_routes AS ROUTES ON TRIPS.route_id = ROUTES.route_id
            INNER JOIN gtfs_engine_stop_times AS STOP_TIMES ON STOP_TIMES.trip_id = TRIPS.trip_id
            INNER JOIN gtfs_engine_stops AS STOPS ON STOPS.stop_id = STOP_TIMES.stop_id

            WHERE 
                ROUTES.route_type = 3 AND

                <!-- @ifndef stopId -->
                ST_DWithin(
                    STOPS.stop_point, 
                    ST_SetSRID(
                        ST_MakePoint(<!-- @echo lng -->, <!-- @echo lat -->), 4326
                    ), 0.10/111.325
                )
                <!-- @endif -->

                <!-- @ifdef stopId -->
                STOPS.stop_id = '<!-- @echo stopId -->'
                <!-- @endif -->                
            
            ORDER BY shape_id, shape_pt_sequence`

    console.log(pp.preprocess(query, params))
    return new Promise((resolve, reject) => {
      Database.query(pp.preprocess(query, params)).then(res => {
        resolve(res)
      })
      .catch(err => {
        reject(err)
      })
    })
  }
}

module.exports = Map
