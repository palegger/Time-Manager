import { createRouter, createWebHistory } from 'vue-router'
import Welcome from '../components/Welcome.vue';
import WorkingTimes from '../components/WorkingTimes.vue';
import Clock from '../components/Clock.vue';
import Login from '../components/Login.vue'

function navGuard (to, from, next) {
  let jwt = localStorage.getItem("jwt");
  if (jwt) {
    next()
  } else {
    alert("You must be connected to access this page")
  }
}

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login,
  },
  {
    path: '/',
    name: 'Welcome',
    component: Welcome,
    beforeEnter : navGuard
  },
  {
    path: '/workingtimes',
    name: 'Working Times',
    component: WorkingTimes,
    beforeEnter : navGuard
  },
  {
    path: '/clock',
    name: 'Clock',
    component: Clock,
    beforeEnter : navGuard
  }

]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
