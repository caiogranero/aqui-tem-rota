import Vue from 'vue'
import Router from 'vue-router'
import Map from '@/components/Map'

Vue.use(Router)

// TODO: Alterar a rota principal para index e chamar o componente do mapa nele.
export default new Router({
  routes: [
    {
      path: '/',
      name: 'Map',
      component: Map
    }
  ]
})
