import axios from 'axios'

const RoutesInstance = axios.create({
  baseURL: '/api/routes',
  timeout: 30000
})

export default {
  install (Vue) {
    const RoutesService = {
      name: 'RoutesService',

      getAllRoutes (params) {
        return RoutesInstance.get('/', {
          params: params
        })
      }
    }
    Vue.$RoutesService = RoutesService
    Vue.prototype.$RoutesService = RoutesService
  }
}
