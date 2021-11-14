<template> 
  <Navbar/>
  <div id="dashboard-main">
    <div id="dashboard-container">
      <div class="dashboard-left">
        <User/>
      </div>
      <div class="dashboard-right">
        <router-view/>
      </div>
    </div>
  </div>
</template>

<script>
import User from '../components/User.vue'
import Navbar from '../components/Navbar.vue'

export default {
  name: 'Dashboard',
  components: {
    User,
    Navbar
  }
}
</script>
<style scoped>
  
</style>
