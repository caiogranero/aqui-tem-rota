const Database = require('../helpers/Database')
var pp = require('preprocess')

const Stops = {
    getAll(params) {
        const query = 
            `
            SELECT 
                stop_id, stop_name, stop_desc, stop_point, stop_lat, stop_lon
            FROM 
                public.gtfs_engine_stops
            WHERE 
                ST_DWithin(
                    stop_point, 
                    ST_SetSRID(
                        ST_MakePoint(<!-- @echo lng -->, <!-- @echo lat -->), 4326
                    ), 0.3/111.325
                );`
        
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