<template>
  <md-snackbar :md-position="position" ref="snackbar" :md-duration="duration" id="snackbar">
    <span>{{content}}</span>
    <md-button class="md-accent" md-theme="light-blue" @click="$refs.snackbar.close()">{{btnContent}}</md-button>
  </md-snackbar>
</template>

<script>
export default {
  name: 'SnackBar',
  props: {
    duration: {
      type: [Number, String],
      default: 3000
    },
    content: String,
    btnContent: {
      type: String,
      default: 'Ok!'
    },
    position: {
      type: String,
      default: 'top center'
    },
    open: Boolean
  },
  watch: {
    open () {
      this.$refs.snackbar.open()
    }
  }
}
</script>

<style scoped>
</style>
