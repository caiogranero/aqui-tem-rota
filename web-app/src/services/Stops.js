import axios from 'axios'

const StopsInstance = axios.create({
  baseURL: '/api',
  timeout: 5000
})

export default {
  install (Vue) {
    const StopsService = {
      name: 'StopsService',

      getAllStops (params) {
        return StopsInstance.get('/stops', {
          params: params
        })
      }
    }
    Vue.$StopsService = StopsService
    Vue.prototype.$StopsService = StopsService
  }
}
