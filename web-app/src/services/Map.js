import axios from 'axios'

const MapInstance = axios.create({
  baseURL: '/api/map',
  timeout: 30000
})

export default {
  install (Vue) {
    const MapService = {
      name: 'MapService',

      get (params) {
        return MapInstance.get('/', {
          params: params
        })
      }
    }
    Vue.$MapService = MapService
    Vue.prototype.$MapService = MapService
  }
}
