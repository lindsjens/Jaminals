<template>
  <div class="search-event">
      <h2>Event Search</h2>
      <div class="norm-core-input">
        <b-form-input  v-model="eventSearchString" placeholder="Type an event"></b-form-input>
  </div>
      <div v-for="event in filteredEvents" v-bind:key="event.id">
         <hr>
              <h2> <router-link v-bind:to="{name:'event', params: {id: event.id} }">{{ event.name }} </router-link></h2>
          <p>{{ event.information }}</p>

      </div>
  </div>
</template>

<script>
import eventService from '../services/EventService.js'


export default {
    name: 'EventSearch',
    data(){
        return {
          
            eventsAll:[],
            eventSearchString: "",
        }
    },
    computed: {
        filteredEvents() {
            let events = this.eventsAll;
            let searchString = this.eventSearchString;
            let cleanSearchString = searchString.trim().toLowerCase();

             // if empty search string
            if(!searchString){
                // return a blank array of events? or show all the events when nothing is typed
                return events;
            }

            events = events.filter((event) => {
                if(event.name.toLowerCase().indexOf(cleanSearchString) !== -1){
                    return event
                }
            })

            return events;
        }

    },


    created(){
        eventService.getEvents()
        .then((response) => {
            this.eventsAll = response.data;
            // console.log(response.data);
        })
    }


}
</script>

<style scoped>
.search-event {
    border:#003B77 5px solid;
    padding: 5px;
    border-radius: 10px;
}
a{
    color: #003B77;
}
.norm-core-input{
    font-family: sans-serif;
}

    
</style>