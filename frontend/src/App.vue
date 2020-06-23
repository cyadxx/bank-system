<template>
  <div id="app">
    <home-page></home-page>
  </div>
</template>

<script>
import HomePage from '@/components/HomePage'

export default {
  name: 'App',
  components: {
    HomePage
  }
}
</script>

<style>
body {
  margin: 0;
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
