<template lang="pug">
  #sample_vue_app
    p
      |{{ message }}
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style lang="stylus" scoped>
p
  font-size: 2em
  text-align: center
</style>
