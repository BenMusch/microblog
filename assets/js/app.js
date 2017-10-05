import "phoenix_html"
import Like from "./components/like.vue"

/*
 * For some reason, calling this function here prevents an error when using this
 * function in my *.vue files. Weird.
 */
JSON.stringify("hello")

window.vms = new Vue({
  components: {
    'like-btn': Like
  }
}).$mount('#app-container')
