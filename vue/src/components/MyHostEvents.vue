<template>
  <div class="search-event">
      <h2>My Events as Host Search</h2>
      <div>
        <b-form-input class="search" v-model="eventSearchString" placeholder="Type an event"></b-form-input>
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
    name: 'MyHostEvents',
    data(){
        return {
            hostEvents:[],
            eventSearchString: "",
        }
    },
    computed: {
        filteredEvents() {
            let events = this.hostEvents;
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
        eventService.getEventsByHostId(this.$store.state.user.id)
        .then((response) => {
            console.log(response)
            this.hostEvents = response.data;
            // const responseEventsAll = response.data;
            // this.eventsAll = responseEventsAll.filter((event) => event.userId == this.$store.state.user.id);
            
        })
    }


}
</script>

<style scoped>
.search{
    font-family: sans-serif;
}
.search-event {
    border:#003B77 5px solid;
    padding: 5px;
    border-radius: 10px;
  background-color: #FC05F4;
}
a{
    color: #003B77;
}
    
</style>