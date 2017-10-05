import "phoenix_html"
import App from "./components/app.vue"

window.vms = new Vue({
  components: {
    'app': App
  }
}).$mount('#app-container')
