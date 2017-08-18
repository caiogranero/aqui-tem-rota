const Database = require('../helpers/Database')
var pp = require('preprocess')

const Stops = {
    getAll(params) {
        const query = 
            `
            SELECT 
                SHAPES.shape_id,    
                SHAPES.shape_pt_lon,
                SHAPES.shape_pt_lat,
                STOPS.stop_name,
                STOPS.stop_lat,
                STOPS.stop_lon
            FROM gtfs_engine_shapes AS SHAPES
            INNER JOIN gtfs_engine_trips AS TRIPS ON SHAPES.shape_id = TRIPS.shape_id
            INNER JOIN gtfs_engine_routes AS ROUTES ON TRIPS.route_id = ROUTES.route_id
            INNER JOIN gtfs_engine_stop_times AS STOP_TIMES ON STOP_TIMES.trip_id = TRIPS.trip_id
            INNER JOIN gtfs_engine_stops AS STOPS ON STOPS.stop_id = STOP_TIMES.stop_id

            WHERE 
                ROUTES.route_type = 3 AND 
                ST_DWithin(
                    STOPS.stop_point, 
                    ST_SetSRID(
                        ST_MakePoint(<!-- @echo lng -->, <!-- @echo lat -->), 4326
                    ), 0.15/111.325
                )
            
            ORDER BY shape_id, shape_pt_sequence`
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

module.exports = Stops