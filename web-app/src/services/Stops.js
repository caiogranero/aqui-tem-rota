import axios from 'axios'

const StopsInstance = axios.create({
  baseURL: '/api/stops',
  timeout: 30000
})

export default {
  install (Vue) {
    const StopsService = {
      name: 'StopsService',

      getAllStops (params) {
        return StopsInstance.get('/', {
          params: params
        })
      }
    }
    Vue.$StopsService = StopsService
    Vue.prototype.$StopsService = StopsService
  }
}
