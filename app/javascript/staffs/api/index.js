import Vue from 'vue'
import axios from 'axios'

const api = {
    data: {
        csrfToken: () => document.querySelector('head > meta[name=csrf-token]').content,
    },
    clients: {
        index: () => axios.get('/client/clients/clients_data'),
        create: (email, password, fullname, phone) => axios.post('/client/clients', {
            client: {
                email: email,
                password: password,
                fullname: fullname,
                phone: phone
            },
            authenticity_token: api.data.csrfToken()
        }),
        fetchUserData: () => axios.get('/staff/staffs/user_data'),
        logout: () => axios.delete('/users/sign_out',
            { headers: { "X-CSRF-Token": api.data.csrfToken(), "X-Vue-Redirect-Control": true } })
            .then(() => { window.location.href = '/' })
    }
}

Vue.prototype.$api = api