<template>
  <div id="app">
    <navbar></navbar>
    <router-view class="router"></router-view>
    <!-- <BottomBar></BottomBar> -->
  </div>
</template>

<script>
import BottomBar from '@/components/BottomBar'
import Navbar from '@/components/Navbar'

export default {
  name: 'app',
  components: { Navbar, BottomBar }
}
</script>

<style>
html, body{
  height: 100%
}
</style>
