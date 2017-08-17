<template>
  <div class="map">
    <v-map v-on:l-click="onClick($event)" :zoom="zoom" :center="center">
      <v-tilelayer  :url="url" :attribution="attribution"></v-tilelayer>
      <v-marker v-for="stop in stops" :key="stop.stop_id" :lat-lng="stop.position"></v-marker>
      <v-poly v-for="route in routes" :key="route.shape_id" :lat-lngs="route.position" :visible="true" v-on:l-click="whatShape(route.shape_id)"></v-poly>  
    </v-map>
  </div>
</template>

<script>
/* global L:true */

import mixins from '@/components/mixins'

export default {
  name: 'Map',
  mixins: [mixins],
  data () {
    return {
      zoom: 100,
      center: [-23.550277533841815, -46.63393735885621],
      routes: [],
      url: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      stops: [],
      pointToSearch: {}
    }
  },
  methods: {
    whatShape (shapeId) {
      alert(shapeId)
    },

    // Evento de click no mapa.
    // Ao ser clicado, altera o centro do mapa e consulta todos os pontos de ônibus próximos aquele local.
    onClick ($event) {
      this.pointToSearch.lat = $event.latlng.lat
      this.pointToSearch.lng = $event.latlng.lng
      this.center = [$event.latlng.lat, $event.latlng.lng]
      this.getRoutes()
      // this.getStopsPoint()
    },

    // Consulta os pontos de ônibus próximos a posição informada
    getStopsPoint () {
      this.stops = []
      const params = {lat: this.pointToSearch.lat, lng: this.pointToSearch.lng}
      this.$StopsService.getAllStops(params).then(res => {
        if (!res.data.error) {
          res.data.results.rows.forEach((item, index) => {
            this.stops.push({
              stop_id: item.stop_id,
              position: L.latLng(item.stop_lat, item.stop_lon)
            })
          })
        }
      })
    },

    // Consulta todas as informações de pontos de ônibus e rotas
    // para a posição que o usuário escolheu
    getRoutes () {
      this.stops = []
      this.A = []
      const params = {lat: this.pointToSearch.lat, lng: this.pointToSearch.lng}
      this.$RoutesService.getAllRoutes(params).then(res => {
        if (!res.data.error) {
          const data = this._.groupBy(res.data.results.rows, (row) => {
            return row.shape_id
          })
          let stops = []
          let routes = []
          let count = 0
          this._.forIn(data, (shapes, idx) => {
            routes.push([])
            shapes.forEach((route) => {
              stops.push({
                stop_id: route.stop_id,
                position: L.latLng(route.stop_lat, route.stop_lon)
              })

              if (routes[count].length !== 0) {
                routes[count].position.push([route.shape_pt_lat, route.shape_pt_lon])
              } else {
                routes[count] = {
                  shape_id: route.shape_id,
                  position: [[route.shape_pt_lat, route.shape_pt_lon]]
                }
              }
            })
            count++
          })

          this.stops = this._.uniqWith(stops, this._.isEqual)
          this.routes = routes
        }
      })
    }
  },
  created () {
    // Ao carregar a página, captura a posição atual do usuário,
    // centraliza o mapa e busca os pontos de ônibus próximos
    this.getPosition().then((position) => {
      this.$store.commit('setUserPosition', {lat: position.coords.latitude, lng: position.coords.longitude})
      // this.center = [position.coords.latitude, position.coords.longitude]
      // this.getRoutes()
    })
    .catch((err) => {
      console.error(err.message)
    })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.map {
  height: 100vh;
}
</style>
