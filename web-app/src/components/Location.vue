<template>
  <div id="location">
    <snack-bar :content="snackBarContent" :open="openSnackBar"></snack-bar>
    <md-button class="md-button" id="location-button" @click="getUserPosition()">
      <md-icon md-iconset="fa fa-location-arrow disabled" id="location-icon" class="md-size-1x"></md-icon>
    </md-button>
  </div>
</template>

<script>
import SnackBar from '@/components/SnackBar'
import mixin from '@/components/mixins'

export default {
  name: 'Location',
  data () {
    return {
      snackBarContent: '',
      openSnackBar: false
    }
  },
  mixins: [mixin],
  components: { SnackBar },
  methods: {
    getUserPosition () {
      this.getPosition().then(position => {
        document.getElementById('location-icon').classList.remove('disabld')
        document.getElementById('location-icon').classList.add('enabled')
        this.$store.commit('setUserPosition', {lat: position.coords.latitude, lng: position.coords.longitude})
      }, err => {
        console.error(err.message)
        document.getElementById('location-icon').classList.remove('enabled')
        document.getElementById('location-icon').classList.add('disabled')
        this.snackBarContent = 'Não foi possível obter sua localização.'
        this.openSnackBar = !this.openSnackBar
      })
    }
  },
  created () {
    // Ao carregar a página, captura a posição atual do usuário,
    // centraliza o mapa e busca os pontos de ônibus próximos
    this.getUserPosition()
  }
}
</script>

<style scoped>

#location-button {
  float: left;
  background-color: white;
  color: #BDBDBD;
  margin-top: 80px;
  margin-left: 10px;
  height: 34px;
  min-height: 34px;
  width: 34px;
  min-width: 34px;
  padding: 0px 6px;
  border: 2px double #BDBDBD;
}

#location-icon {
  display: flex;
}

#location-button > #location-icon.disabled {
  color: #BDBDBD
}

#location-button > #location-icon.enabled {
  color: #01579B
}
</style>
