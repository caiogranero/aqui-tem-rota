const mixins = {
  methods: {
    getPosition (options) {
      return new Promise((resolve, reject) => {
        navigator.geolocation.getCurrentPosition(resolve, reject, options)
      })
    },
    makeColor (colorNum, colors) {
      if (colors < 1) colors = 1
      return colorNum * (360 / colors) % 360
    }
  }
}

export default mixins
