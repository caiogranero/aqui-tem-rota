<template>
  <div class="map">
    <snack-bar :content="snackBarContent" :open="showSnackBar"></snack-bar>
    <v-map v-on:l-click="onClick($event)" :zoom="zoom" :center="center">
      <v-tilelayer  :url="url" :attribution="attribution"></v-tilelayer>
      <v-marker v-for="stop in stopsPoint" :key="stop.id" :lat-lng="stop.position">
        <v-tooltip :content="stop.name"></v-tooltip>
      </v-marker>
      <v-poly v-for="route in routes" 
              :color="route.color" 
              :key="route.shape_id" 
              :lat-lngs="route.position" 
              :visible="true" 
              v-on:l-click="whatShape(route.shape_id)" 
              :weight="route.weight"></v-poly>
    </v-map>
  </div>
</template>

<script>
/* global L:true */

import mixins from '@/components/mixins'
import SnackBar from '@/components/SnackBar'

export default {
  name: 'Map',
  mixins: [mixins],
  data () {
    return {
      zoom: 100,
      center: [-23.550277533841815, -46.63393735885621],
      url: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      pointToSearch: {},
      snackBarContent: '',
      showSnackBar: false
    }
  },
  components: { SnackBar },
  computed: {
    stopsPoint () {
      return this.$store.state.stopsPoint
    },
    routes () {
      return this.$store.state.routes
    }
  },
  watch: {
    '$store.state.userPosition' (userPosition) {
      this.center = [userPosition.lat, userPosition.lng]
      this.pointToSearch.lat = userPosition.lat
      this.pointToSearch.lng = userPosition.lng
      this.getRoutes()
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
    },

    // Recebe um Map com a posição dos pontos de ônibus key: stop_id e value: LatLng
    setStopsPoint (map) {
      let stops = []
      for (var entrie of map) {
        stops.push({
          id: entrie[0],
          position: entrie[1].position,
          name: entrie[1].name
        })
      }

      this.$store.commit('setStopsPoint', stops)
    },

    // Consulta todas as informações de pontos de ônibus e rotas
    // para a posição que o usuário escolheu
    getRoutes () {
      this.stops = []
      const params = {lat: this.pointToSearch.lat, lng: this.pointToSearch.lng}
      this.$RoutesService.getAllRoutes(params).then(res => {
        if (res.data.results.rowCount > 0) {
          const data = this._.groupBy(res.data.results.rows, (row) => {
            return row.shape_id
          })
          // Cria um Map para garantir que não vá ser inserido pontos de paradas repetidos
          let StopMap = new Map()
          let routes = []
          let count = 0
          this._.forIn(data, (shapes, idx) => {
            routes.push([])
            shapes.forEach((route) => {
              StopMap.set(route.stop_id, {
                position: L.latLng(route.stop_lat, route.stop_lon),
                name: route.stop_name
              })

              if (routes[count].length !== 0) {
                routes[count].position.push([route.shape_pt_lat, route.shape_pt_lon])
              } else {
                routes[count] = {
                  shape_id: route.shape_id,
                  position: [[route.shape_pt_lat, route.shape_pt_lon]],
                  color: '#90CAF9',
                  route_id: route.route_id,
                  trip_headsign: route.trip_headsign,
                  weight: 3
                }
              }
            })
            count++
          })

          this.setStopsPoint(StopMap)
          this.$store.commit('setRoutes', routes)
        } else {
          this.$store.commit('setStopsPoint', [])
          this.$store.commit('setRoutes', [])
          this.snackBarContent = 'Não há linhas de ônibus nas proximidades, escolha outro lugar do mapa!'
          this.showSnackBar = !this.showSnackBar
        }
      })
    }
  }
}
</script>

<style scoped>
.map {
  height: 100vh;
  z-index: 0;
}
</style>
