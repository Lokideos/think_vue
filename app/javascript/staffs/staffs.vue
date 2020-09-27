<template lang="pug">
  #app
    navbar
    h1 {{ message }}
</template>

<script>
import axios from 'axios'
import Navbar from "./navbar/navbar";

export default {
  data: function () {
    return {
      message: "Staffs Application",
    }
  },
  components: {
    'navbar': Navbar
  }
}
</script>

<style scoped>
h1 {
  font-size: 2em;
  text-align: center;
}
</style>
