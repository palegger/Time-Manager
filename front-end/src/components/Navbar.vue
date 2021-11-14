<template>
    <div id="dashboard-navbar">
      <div class="navbar-link-container">
        <div class="navbar-link-item">
          <router-link class="link-item-text" to="/">Home</router-link>
          <router-link to="/"><fa class="link-item-icon" icon="home"/></router-link>
        </div>
        <div class="navbar-link-item">
          <router-link class="link-item-text" to="/workingtimes">Working Times</router-link>
          <router-link to="/workingtimes"><fa class="link-item-icon" icon="user-clock"/></router-link> 
        </div>
        <div class="navbar-link-item">
          <router-link class="link-item-text" to="/clock">Clock Manager</router-link>
          <router-link to="/clock"><fa class="link-item-icon" icon="stopwatch"/></router-link>
        </div>
        <div class="navbar-link-item">
          <router-link class="link-item-text" to="/">Chart Manager</router-link>
          <router-link to="/"><fa class="link-item-icon" icon="chart-pie"/></router-link>
        </div>
      </div>
      <div class="navbar-right">
        Time Manager
      </div>
    </div>
</template>
<script>

export default {
    name: "Navbar",
    props : {
    
    },
    data : function () {
        return {
           
        }
    },
    created : function () {
       
    },
    methods : {
       
    }
}
</script>
<style scoped>
    #dashboard-navbar {
    display: flex;
    height: 80px;
    width: calc(100% - 100px);
    background: #44BBA4;
    padding: 0px 50px;
  }

  #dashboard-navbar .navbar-link-container {
    display: flex;
    width: 60%;
    height: 100%;
    /* justify-content: space-around; */
    align-items: center;
  }
  #dashboard-navbar .navbar-right {
    display: flex;
    align-items: center;
    justify-content: right;
    width: 40%;
    font-weight: 600;
    color: white;
    font-size: 1.3em;
    user-select: none;
  }

  #dashboard-navbar .navbar-link-container .navbar-link-item {
    padding: 10px 20px;
    background: #393E41;
    margin: 0px 10px;
    border-radius: 15px;
    cursor: pointer;
    height: 2.2em;
    display: flex;
    align-items: center ;
    text-align: center;
  }

  #dashboard-navbar .navbar-link-container .navbar-link-item:hover {
    /* transform: opacity(1.2); */
    opacity: 0.8;
    transition-duration: 500ms;
    transition-property: opacity;
  }

  #dashboard-navbar .navbar-link-container .navbar-link-item a {
    color: #44BBA4  ;
    text-decoration: none;
    font-weight: 800;
  }

  .navbar-link-container .link-item-icon {
    color:#44BBA4
  }

    @media screen and (max-width: 640px) {
        #dashboard-navbar {
            position: fixed;
            bottom: -1px;
            overflow-y: scroll;
            z-index: 11;
        }
        #dashboard-navbar .navbar-link-container {
            display: flex;
            width: 100%;
            justify-content: space-around;
            align-items: center;
        }
        .navbar-link-container .link-item-text {
            display: none;
        }
        .navbar-link-container .link-item-icon {
            display: unset;
        }
        #dashboard-navbar .navbar-right {
            display: none;
        }
    }

    @media screen and (min-width: 640px) {
        .navbar-link-container .link-item-text {
             display: unset;
        }
        .navbar-link-container .link-item-icon {
            display: none;
        }
    }
</style>
