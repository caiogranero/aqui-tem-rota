<template>
  <div id="app">
    <sidebar></sidebar>
    <router-view id="page-content"></router-view>
  </div>
</template>

<script>
import Sidebar from '@/components/Sidebar'

export default {
  name: 'app',
  components: { Sidebar }
}
</script>

<style>

body {
  margin: 0px
}

#app {
  overflow-x: hidden;
  position:relative;
  height:100vh;
}

#sidebar {
  z-index: 1;
  position: absolute;
  height: 100%;
  left: 95%;
}

#page-content {
  position: relative;
}


</style>
