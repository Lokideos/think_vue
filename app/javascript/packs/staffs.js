import Vue from 'vue'
import App from '../staffs/staffs.vue'
import '../staffs/api'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
