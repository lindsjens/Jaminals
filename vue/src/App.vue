<template>
  <div id="app">
    <div id="nav">
  <b-nav>   

   <b-button variant="outline-light"><router-link v-bind:to="{ name: 'home' }">Home</router-link></b-button>
    <b-button v-if="$store.state.token == ''" variant="outline-light"><router-link v-bind:to="{name: 'login'}" >Login as DJ or Host </router-link> </b-button>
    <b-nav-item v-if="$store.state.token != ''"><router-link v-bind:to="{ name: 'logout' }" >Logout</router-link></b-nav-item>
  <!-- <div v->

  </div> -->
   
  </b-nav>
  
</div>
  <router-view />

  </div>
  
</template>
<style scoped>
#app {
   background-color: #090531;
   height: 100vh;
}
#nav{
  background-color: #FC05F4;
  font-family: "Audiowide", sans-serif;
   
}
a{
  color: #090531;
}
</style>
