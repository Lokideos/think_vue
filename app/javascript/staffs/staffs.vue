<template lang="pug">
  #app
    navbar
    h1 {{ message }}
    dashboard
</template>

<script>
import axios from 'axios'
import Navbar from "./components/navbar/navbar";
import Dashboard from "./components/dashboard/dashboard"

export default {
  data: function () {
    return {
      message: "Staffs Application",
    }
  },
  components: {
    'navbar': Navbar,
    'dashboard': Dashboard
  }
}
</script>

<style scoped>
h1 {
  font-size: 2em;
  text-align: center;
}
</style>
