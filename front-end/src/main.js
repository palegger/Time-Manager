import { createApp } from 'vue'
// import Vue from 'vue'
import App from './App.vue'
import router from './router'
import VueJwtDecode from 'vue-jwt-decode'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faClock, faStopwatch, faUserClock, faHome, faChartPie } from '@fortawesome/free-solid-svg-icons'
library.add(faClock, faStopwatch, faUserClock, faHome, faChartPie)
import './assets/css/main.css';
import { GlobalMethods } from './assets/js/main'


// Vue.component('font-awesome-icon', FontAwesomeIcon)

createApp(App).component("fa", FontAwesomeIcon).use(router, VueJwtDecode).mixin(GlobalMethods).mount('#app')

