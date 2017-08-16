// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import Vue2Leaflet from 'vue2-leaflet'
import lodash from 'lodash'
import VueLodash from 'vue-lodash/dist/vue-lodash.min'

Vue.config.productionTip = false

Vue.component('v-map', Vue2Leaflet.Map)
Vue.component('v-tilelayer', Vue2Leaflet.TileLayer)
Vue.component('v-marker', Vue2Leaflet.Marker)
Vue.component('v-poly', Vue2Leaflet.Polyline)

Vue.use(VueLodash, lodash)

import AppServices from './services'
Object.keys(AppServices).forEach(k => Vue.use(AppServices[k]))

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: { App }
})
