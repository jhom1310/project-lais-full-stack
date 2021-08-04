<template>
  <div class="log">
    <h1>Até logo</h1>
  </div>
</template>

<script>
  export default {
    created () {
      this.$store.dispatch('logoutUser')
        .then(() => {
          this.$router.push({ name: 'home' })
        })
    }
  }
</script>

<style scoped>
</style>
