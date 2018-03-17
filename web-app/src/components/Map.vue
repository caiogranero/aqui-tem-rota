<template>
  <div>
    <location></location>

    <div id="map-container" :style="{height:mapHeight}">
      <snack-bar :content="snackBarContent" :open="showSnackBar" :duration="durationMessage"></snack-bar>

      <v-map v-on:l-click="onClick($event)" :zoom="zoom" :center="center">
        <v-circle :radius="4" :latLng="center" :weight="2"></v-circle>
        <v-tilelayer :url="url" :attribution="attribution"></v-tilelayer>
        <v-marker v-for="stop in stopsPoint" :key="stop.id" :lat-lng="stop.position" v-on:l-click="selectStopPoint(stop.id)">
          <v-tooltip :content="stop.name"></v-tooltip>
        </v-marker>
        <v-poly v-for="route in routes" 
                :color="route.color" 
                :key="route.shape_id" 
                :lat-lngs="route.position" 
                :visible="true" 
                v-on:l-click="selectRoute(route.shape_id)" 
                :weight="route.weight"></v-poly>
      </v-map>
    </div>
  </div>
</template>

<script>
/* global L:true */
/* eslint camelcase: 0 */

import mixins from '@/components/mixins'
import SnackBar from '@/components/SnackBar'
import Location from '@/components/Location'

export default {
  name: 'Map',
  mixins: [mixins],
  data () {
    return {
      mapHeight: '900px',
      zoom: 100,
      center: [-23.550277533841815, -46.63393735885621],
      url: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      attribution: '&copy; Desenvolvido por <a target="_blank" href="https://github.com/caiogranero">Caio Granero</a>',
      pointToSearch: {},
      snackBarContent: '',
      showSnackBar: false,
      selectingRoute: false,
      durationMessage: 3000
    }
  },
  components: { SnackBar, Location },

  mounted () {
    this.calcMapHeight()
    // TODO: Colocar debounce na funçao
    window.onresize = (event) => {
      this.calcMapHeight()
    }
  },

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
      const params = {lat: this.pointToSearch.lat, lng: this.pointToSearch.lng}
      this.getRoutes(params)
    }
  },
  methods: {
    calcMapHeight () {
      const windowHeight = document.getElementsByTagName('html')[0].clientHeight
      const headerHeight = document.getElementsByTagName('header')[0].clientHeight

      const diffHeight = windowHeight - headerHeight

      this.mapHeight = diffHeight.toString() + 'px'
    },

    selectStopPoint (stopId) {
      const params = { stopId }
      this.getRoutes(params)
    },
    // On select a route in the map
    selectRoute (shape_id) {
      this.selectingRoute = true
      this.routes.forEach((route, idx) => {
        if (route.shape_id === shape_id) {
          route.color = '#48657C'
          route.weight = 7
        } else {
          route.color = '#C090F9'
          route.weight = 3
        }
      })

      this.$store.commit('setRoutes', this.routes)
      setTimeout(() => {
        this.selectingRoute = false
      }, 100)
    },

    // Evento de click no mapa.
    // Ao ser clicado, altera o centro do mapa e consulta todos os pontos de ônibus próximos aquele local.
    onClick ($event) {
      if (!this.selectingRoute) {
        this.pointToSearch.lat = $event.latlng.lat
        this.pointToSearch.lng = $event.latlng.lng
        this.center = [$event.latlng.lat, $event.latlng.lng]
        const params = {lat: this.pointToSearch.lat, lng: this.pointToSearch.lng}
        this.getRoutes(params)
      }
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
    getRoutes (params) {
      this.stops = []
      this.durationMessage = 'Infinity'
      this.snackBarContent = 'Aguarde enquanto as informações são carregadas...'
      this.showSnackBar = !this.showSnackBar

      this.$MapService.get(params).then(res => {
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
                  color: '#C090F9',
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
          this.snackBarContent = 'Não há linhas de ônibus nas proximidades'
          this.durationMessage = 3000
          this.showSnackBar = !this.showSnackBar
        }
        this.durationMessage = 1000
      })
    }
  }
}
</script>

<style scoped>
#map-container {
  z-index: 0;
  position: relative;
}
</style>
