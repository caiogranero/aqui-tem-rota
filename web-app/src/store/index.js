import Vue from 'vue'
import Vuex from 'vuex'

import state from './state'
import mutations from './mutations'
import actions from './actions'

Vue.use(Vuex)

const store = {
  state,
  mutations,
  actions
}

export default new Vuex.Store(store)
