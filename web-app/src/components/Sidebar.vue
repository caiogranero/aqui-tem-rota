<template>
  <div class="phone-viewport" id="sidebar">
    <md-button class="md-icon-button" id="toggle-button" @click="toggleRightSidenav">
      <md-icon md-iconset="fa fa-bars" class="md-size-1x md-primary"></md-icon>      
    </md-button>

    <md-sidenav class="md-right" id="side-nav" ref="rightSidenav" @open="open('Right')" @close="close('Right')">
      <md-list class="md-dense" v-if="stopsPoint.length > 0">
        <md-list-item>
          <div class="md-list-text-container">
            <span>Pontos mais próximos</span>
          </div>
        </md-list-item>
        <md-list-item v-for="stop in stopsPoint" :key="stop.id">
          <md-icon class="sidebar-icons" md-iconset="fa fa-map-marker"></md-icon>

          <div class="md-list-text-container">
            <span>{{stop.name}}</span>
          </div>
        </md-list-item>
      </md-list>
      <md-list class="md-dense" v-if="routes.length > 0">
        <md-list-item>
          <div class="md-list-text-container">
            <span>Linhas</span>
          </div>
        </md-list-item>
        <md-list-item :class="route.status" v-for="route in routes" :key="route.trip_id" @click="selectRoute(route.shape_id)" @mouseover.native="selectRoute(route.shape_id)">
          <md-icon class="sidebar-icons" md-iconset="fa fa-bus"></md-icon>

          <div class="md-list-text-container">
            <span>{{route.route_id}} - {{route.trip_headsign}}</span>
          </div>
        </md-list-item>
      </md-list>
      <md-button class="md-raised md-primary" @click="closeRightSidenav">Fechar</md-button>
    </md-sidenav>
  </div>
</template>

<script>
/* eslint camelcase: 0 */
export default {
  name: 'Sidebar',
  data () {
    return {
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
  methods: {
    toggleRightSidenav () {
      this.$refs.rightSidenav.toggle()
    },
    closeRightSidenav () {
      this.$refs.rightSidenav.close()
    },
    open (ref) {
      console.log('Opened: ' + ref)
    },
    close (ref) {
      console.log('Closed: ' + ref)
    },
    selectRoute (shape_id) {
      this.routes.forEach((route, idx) => {
        if (route.shape_id === shape_id) {
          route.color = '#48657C'
          route.weight = 7
          route.status = 'selected'
        } else {
          route.color = '#C090F9'
          route.weight = 3
          route.status = ''
        }
      })

      this.$store.commit('setRoutes', this.routes)
    }
  }
}
</script>

<style scoped>

#toggle-button {
  float: right;
  background-color: white;
  margin-top: 20px;
  margin-right: 30px;
}

#side-nav .sidebar-icons {
  margin-right: 10px;
}

#side-nav span {
  font-size: 14px;
}

.menu-list-selected {
  background-color: rgba(153, 153, 153, 0.2)
}
</style>
