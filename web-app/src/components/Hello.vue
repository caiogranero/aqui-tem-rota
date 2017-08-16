<template>
  <div class="map">
    <v-map v-on:l-click="onClick($event)" :zoom="zoom" :center="center">
      <v-tilelayer  :url="url" :attribution="attribution"></v-tilelayer>
      <v-marker v-for="stop in stops" :key="stop" :lat-lng="stop"></v-marker>
      <!-- <v-poly :lat-lngs="points" :visible="true" v-on:l-click="alert(item.polyline)"></v-poly> -->
    </v-map>
  </div>
</template>

<script>
import mixins from '@/components/mixins'

export default {
  name: 'Map',
  mixins: [mixins],
  data () {
    return {
      zoom: 100,
      center: [-23.432175, -46.787116],
      routes: [],
      url: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
      stops: [], //
      pointToSearch: {}
    }
  },
  methods: {
    onClick ($event) {
      this.pointToSearch.lat = $event.latlng.lat
      this.pointToSearch.lng = $event.latlng.lng
      this.center.push($event.latlng.lat, $event.latlng.lng)
      this.getStopsPoint()
    },
    getStopsPoint () {
      this.stops = []
      const params = {lat: this.pointToSearch.lat, lng: this.pointToSearch.lng}
      this.$StopsService.getAllStops(params).then(res => {
        if (!res.data.error) {
          res.data.results.rows.forEach((item, index) => {
            this.stops.push(L.latLng(item.stop_lat, item.stop_lon))
          })
        }
      })
    }
  },
  created () {
    // this.getPosition().then((position) => {
    //   this.pointToSearch = position
    //   this.getStopsPoint()
    // })
    // .catch((err) => {
    //   console.error(err.message);
    // })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.map {
  height: 600px;
}
</style>
