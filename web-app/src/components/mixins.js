const mixins = {
  methods: {
    getPosition (options) {
      return new Promise((resolve, reject) => {
        navigator.geolocation.getCurrentPosition(resolve, reject, options)
      })
    }
  }
}

export default mixins
