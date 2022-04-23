<template>
  <div class="Event">
      <div class="event-data">
        <h1>
            EVENT: {{event.name}}
        </h1>
        
        
    </div>
       <div v-if="hasPermissionToEditEvent">
         <router-link v-bind:to="{name: 'eventEdit', params:{id: this.event.id}}">
            <b-button  variant="warning">EDIT this Event</b-button>
        </router-link>
    </div>
     <b-container class="bv-example-row">
      <b-row>
        <b-col>
          <div v-if="eventSongs !== null" class="Table">
        <h4>The Songs:</h4>
        <b-table striped hover :items="eventSongs" :fields="fields"></b-table>
    </div>
        </b-col>
        <b-col>
            <!-- <h2>Featuring: {{ djForThisEvent.username }}</h2> -->
        <h4>
            Event Information:  {{event.information}}
        </h4>
            <view-add-dj-songs-to-event v-if="isDjLoaded" :dj ="this.djForThisEvent" :eventSongs="this.eventSongs" :event="event" />
            </b-col>
      </b-row>
</b-container>
        
    
  
  </div>
</template>

<script>
import eventService from '../services/EventService.js'
import songService from '../services/SongService.js'
import hostService from '../services/HostService.js'
import dJService from '../services/DJService.js'
import ViewAddDjSongsToEvent from '../components/ViewAddDJSongsToEvent.vue'

export default {
    name: 'event',
    components: {ViewAddDjSongsToEvent},
    data(){
        return {  
            fields: [
                {key: 'artistName', sortable: true},
                {key: 'name', sortable:true}
            ],
            event: {},
            eventSongs: [],
            hosts: [],
            hostsForThisEvent: [],
            djForThisEvent: {},
            isDjLoaded: false,
        }
    },
    methods: {
      
    },
    computed: {
         hasPermissionToEditEvent(){
            const hasThisHostInEvent = this.hostsForThisEvent.some((host) => host.id = this.$store.state.user.id)
            if(this.$store.state.token == ''){
                return false;
                // || this.$store.state.user.id == 
            }else if(this.$store.state.user.authorities[0].name == 'ROLE_DJ' || this.$store.state.user.authorities[0].name == 'ROLE_HOST' && this.$store.state.user.id == this.event.userId || hasThisHostInEvent  ){
                return true;
            } else {
                return false;
            }
        }
    },
    created(){
        //todo add error handling for the request
        eventService.getEventById(this.$route.params.id)
        .then(
            (response)=>{
                this.event = response.data; 
                // set djInfo for this event
                this.djForThisEvent = this.$store.state.djs.find((dj)=> {
                    dj.id == event.userId
                })
               dJService.getDjs()
                .then((response) => {
                    const allDjs = response.data;
                    
                    this.djForThisEvent = allDjs.find((element) => element.id == this.event.userId)
                    this.isDjLoaded = true;
                        
            }) 
            

            });
        

        songService.getSongsByEvent(this.$route.params.id)
            .then((response) => {
                this.eventSongs = response.data;
            });
        

        // // this really only needs to be done for the DJ view - when logged in
        // hostService.getHosts()
        //     .then((response) => {
        //         this.hosts = response.data;
        //     });
        hostService.getHostsByEventId(this.$route.params.id)
            .then((response) => {
                // console.log(response)
                this.hostsForThisEvent = response.data;
            });
        
    }
}
</script>
<style>
    .Event{
        background-color: #090531;
        color: white;
        font-family: "Audiowide", sans-serif;
    }
    .Table{
        background-color: #01F8E9;
    }
</style>