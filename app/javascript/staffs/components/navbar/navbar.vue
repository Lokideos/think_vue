<template lang="pug">
  header.navbar
    a.logo(href="/")
      picture
        img.logo__image(src="./img/vue_logo.svg" alt="Vue App logo" width="50" height="50")
    template(v-if="userDataLoading")
      .authentication
    template(v-else)
      .authentication
        p.authentication__user-email {{ userEmail }}
        a.authentication__logout(v-on:click="logout($event)" href="/users/sign_out" rel="nofollow")
          | logout
</template>

<script>
export default {
  name: 'Navbar',
  data: function () {
    return {
      userDataLoading: true,
      userEmail: {},
      csrfToken: document.querySelector('head > meta[name=csrf-token]').content
    }
  },
  created () {
    this.fetchUserData()
  },
  methods: {
    fetchUserData() {
      this.$api.clients.fetchUserData()
          .then(({ data }) => {
            this.userEmail = data.data.attributes.email
          })
          .finally(() => this.userDataLoading = false)
    },
    logout(event) {
      if (event) {
        event.preventDefault()
      }

      this.$api.clients.logout()
    }
  }
}
</script>

<style lang="scss">
.navbar {
  display: flex;
  justify-content: space-between;
}
.authentication {
  display: flex;
  justify-content: space-between;
}
.authentication__user-email {
  margin: 0;
  padding: 0;
}
.authentication__logout {
  margin: 0;
  margin-left: 10px;
  padding: 0;
}
</style>