<template>
  <div class="map">
    <v-map v-on:l-click="onClick($event)" :zoom="zoom" :center="center">
      <v-tilelayer  :url="url" :attribution="attribution"></v-tilelayer>
      <v-marker v-for="stop in stops" :key="stop.stop_id" :lat-lng="stop.position"></v-marker>
      <!-- <v-poly :lat-lngs="points" :visible="true" v-on:l-click="alert(item.polyline)"></v-poly> -->
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
    // Evento de click no mapa.
    // Ao ser clicado, altera o centro do mapa e consulta todos os pontos de ônibus próximos aquele local.
    onClick ($event) {
      this.pointToSearch.lat = $event.latlng.lat
      this.pointToSearch.lng = $event.latlng.lng
      this.center = [$event.latlng.lat, $event.latlng.lng]
      this.getStopsPoint()
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
    }
  },
  created () {
    // Ao carregar a página, captura a posição atual do usuário,
    // centraliza o mapa e busca os pontos de ônibus próximos
    this.getPosition().then((position) => {
      this.$store.commit('setUserPosition', {lat: position.coords.latitude, lng: position.coords.longitude})
      this.center = [position.coords.latitude, position.coords.longitude]
      this.getStopsPoint()
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
  height: 600px;
}
</style>
