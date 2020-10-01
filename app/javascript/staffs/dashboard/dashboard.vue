<template lang="pug">
section.dashboard
  h2.dashboard__header.visually-hidden Clients Dashboard
  table.clients-list
    tr.clients-list__header
      th email
      th fullname
      th phone
    template(v-if="clientDataLoading")
      tbody.clients-list__records
    template(v-else)
      tbody.clients-list__records(v-for="client in clientsData" :key="client.id")
        tr
          td {{ client.attributes.email }}
          td {{ client.attributes.fullname }}
          td {{ client.attributes.phone }}
  form.clients-form(v-on:submit="createUser($event)" method="post" action="/client/clients")
    label(for="client_email") email
    input.clients-form__email(
      v-on:focusin="clearBackground($event)" v-model="client.email" id="client_email" type="email"
      value name="client[email]"
    )
    label(for="client_password") password
    input.clients-form__password(
      v-on:focusin="clearBackground($event)" v-model="client.password" id="client_password"
      type="password" value name="client[password]"
    )
    label(for="client_fullname") fullname
    input.clients-form__fullname(
      v-on:focusin="clearBackground($event)" v-model="client.fullname" id="client_fullname"
      type="text" value name="client[fullname]"
    )
    label(for="client_phone") phone
    input.clients-form__phone(
      v-on:focusin="clearBackground($event)" v-model="client.phone" id="client_phone" type="text"
      value name="client[phone]"
    )
    button.clients-form__submit(type="submit") Create
</template>

<script>
import axios from 'axios'

export default {
  name: 'Dashboard',
  data: function() {
    return {
      clientsData: [],
      client: {
        email: "",
        password: "",
        fullname: "",
        phone: ""
      },
      sentData: {
        emailCorrect: true,
        passwordCorrect: true,
        fullnameCorrect: true,
        phoneCorrect: true
      },
      newClientData: {},
      csrfToken: document.querySelector('head > meta[name=csrf-token]').content,
      clientDataLoading: true
    }
  },
  created() {
    this.fetchClients()
  },
  methods: {
    fetchClients() {
      axios.get('/client/clients/clients_data').then(({ data }) => {
        this.clientsData = data.data
      }).finally(() => this.clientDataLoading = false)
    },
    createUser(event) {
      if (event) {
        event.preventDefault()
      }

      if (
          !this.validateClientParams(
              this.client.email, this.client.password, this.client.fullname, this.client.phone
          )
      ) {
        return
      }

      axios.post('/client/clients',
          {
            client: {
              email: this.client.email,
              password: this.client.password,
              fullname: this.client.fullname,
              phone: this.client.phone
            },
            authenticity_token: this.csrfToken
          })
          .then(({ data }) => { this.newClientData = data.data })
          .then(this.fetchClients)
    },
    validateClientParams(email, password, fullname, phone) {
      this.sentData.emailCorrect = true
      this.sentData.passwordCorrect = true
      this.sentData.fullnameCorrect = true
      this.sentData.phoneCorrect = true

      if (!this.validClientEmail(email)) {
        const clientEmailField = document.querySelector('.clients-form__email')
        clientEmailField.classList.add('client__form--incorrect-data')
        this.sentData.emailCorrect = false
      }
      if (!this.validClientPassword(password)) {
        const clientPasswordField = document.querySelector('.clients-form__password')
        clientPasswordField.classList.add('client__form--incorrect-data')
        this.sentData.passwordCorrect = false
      }
      if (!this.validClientFullname(fullname)) {
        const clientFullnamelField = document.querySelector('.clients-form__fullname')
        clientFullnamelField.classList.add('client__form--incorrect-data')
        this.sentData.fullnameCorrect = false
      }
      if(!this.validClientPhone(phone)) {
        const clientPhoneField = document.querySelector('.clients-form__phone')
        clientPhoneField.classList.add('client__form--incorrect-data')
        this.sentData.phoneCorrect = false
      }
      return this.sentData.emailCorrect && this.sentData.passwordCorrect &&
             this.sentData.fullnameCorrect && this.sentData.phoneCorrect
    },
    validClientEmail(email) {
      const emailRegex = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/
      if (!!email && email.length > 0 && email.match(emailRegex)) {
        return true
      }
    },
    validClientPassword(password) {
      const requiredPasswordLength = 6

      if (!!password && password.length >= requiredPasswordLength) {
        return true
      }
    },
    validClientFullname(fullname) {
      if (!!fullname && fullname.length > 0) {
        return true
      }
    },
    validClientPhone(phone) {
      const phoneRegex = /^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$/g

      if (!!phone && phone.length > 0 && phone.match(phoneRegex)) {
        return true
      }
    },
    clearBackground(event) {
      const element = event.target
      element.classList.remove('client__form--incorrect-data')
    }
  }
}
</script>

<style lang="scss">
.clients {
  list-style: none;
  margin: 0;
  padding: 0;
}
.client__form--incorrect-data {
  background-color: #730E15;
}
.visually-hidden:not(:focus):not(:active),
input[type="checkbox"].visually-hidden,
input[type="radio"].visually-hidden {
  position: absolute;

  width: 1px;
  height: 1px;
  margin: -1px;
  border: 0;
  padding: 0;

  white-space: nowrap;

  -webkit-clip-path: inset(100%);

  clip-path: inset(100%);
  clip: rect(0 0 0 0);
  overflow: hidden;
}
</style>