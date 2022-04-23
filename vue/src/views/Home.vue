<template>
    
  <div class="home">
    <img src= "..\images\jampinktransp.png" />


    
        
      <div v-if="!isAuthenticated">
        
         <b-container class="bv-example-row">
      <b-row>
        <b-col>
          <event-search class="event-search" />
        </b-col>
        <b-col><dj-grid class="dj-grid" /></b-col>
      </b-row>
</b-container>
    </div>    
      
      
      <div v-if="isAuthenticated">
          <h3>Welcome {{this.$store.state.user.username}}</h3>
         <b-container class="bv-example-row">
      <b-row>
        <b-col>
          
        </b-col>
        <b-col>
          <!-- PUT another DJ thing here-->
        </b-col>
      </b-row>
    </b-container>
   </div>
     
      <div v-if="userType == 'ROLE_DJ' ">
        <b-container class="bv-example-row">
            <b-row>
              <b-col>
                <my-dj-events />
              </b-col>
              <b-col>
                <create-event-form />
                
              </b-col>
      </b-row>
      <b-row>
        <b-col>
         
        </b-col>
          </b-row>
       <b-row>
         <my-dj-songs />
         
      </b-row>
      <b-row>
      </b-row>
     
     
</b-container>
      

      </div>

<div v-if="userType == 'ROLE_HOST' ">
         
         <b-container class="bv-example-row">
      <b-row>
        <b-col>
          <!-- put a HOST thing here-->
          <my-host-events />
        </b-col>
        <b-col>
          <!-- PUT another HOST thing here-->
        </b-col>
      </b-row>
</b-container>

      </div>

      <div class= "about-button">
        <b-col lg="10" class="pb-2" ><b-button class="bottom" variant="outline-light" ><router-link v-bind:to="{ name: 'about' }">About</router-link></b-button></b-col>
     </div>   
  
      
  </div>
</template>

<script>
import DjGrid from '../components/DjGrid.vue';
import EventSearch from '../components/EventSearch.vue';
import MyDjEvents from '../components/MyDjEvents.vue';
import MyDjSongs from '../components/MyDjSongs.vue';
import CreateEventForm from '../components/CreateEventForm.vue'
import MyHostEvents from '../components/MyHostEvents.vue'

export default {
  name: "home",
  
  components: { 
    EventSearch,
    DjGrid,
    MyDjSongs,
    MyDjEvents,
    CreateEventForm,
    MyHostEvents  },

  computed: {
    isAuthenticated() {
      return this.$store.state.token != ''
      },
    userType(){
      if(this.$store.state.token == ''){
        return null
          }
        else {
          return this.$store.state.user.authorities[0].name ;
        }
    }
  }
}

</script>

<style scoped>

.home{

  color: white;
  font-family: "Audiowide", sans-serif;
   text-align: center;

   
}


.dj-grid{
  background-color: #01F8E9;
}

.event-search{
  background-color: #FC05F4;
}
 .about-button{
  text-align: right;
} 

</style>
