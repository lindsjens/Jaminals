<template>
  <div class="event-edit">
      <b-container class="bv-example-row">
  <b-row>
    <b-col>
      <h2>EDIT THIS EVENT</h2>
        
        <h4>Genres</h4>
        <div v-for="genre in genresForThisEvent" :key="genre.name">
            <p>{{genre.name}}</p>
        </div>
        <div>
    <b-alert v-model="showDismissibleAlertForGenreUpdate" variant="success" fade dismissible>
    Successfully Updated Genres
    </b-alert>
        <label class="typo__label">Select Genre(s) from this DJ</label>
        <multiselect v-model="genreValue" :options="genres" :multiple="true" label="name" track-by="name" placeholder="Select Genre(s)"></multiselect>
        <b-button v-on:click="updateGenres" variant="primary">Save Genres</b-button>
       </div>

        <b-alert v-model="showDismissibleAlert" variant="success" fade dismissible>
        Successfully Updated Event
        </b-alert>
      <b-form class="information-form" @submit="onSubmit" v-if="isFormDataLoaded">
      <b-form-group
        id="input-group-1"
        label="Event name:"
        label-for="input-name"
        
      >
        <b-form-input
          id="input-name"
          v-model="form.name"
          placeholder="Enter Event Name"
          required
        ></b-form-input>
      </b-form-group>
        <br>
    
    <b-form-group
        id="input-information"
        label="Event information:"
        label-for="input-information"
      >
      <b-form-textarea
      id="input-information"
      v-model="form.information"
      placeholder="Enter event information..."
      rows="3"
      max-rows="6"
    ></b-form-textarea>
    </b-form-group>
     
      <b-button type="submit" variant="primary">Update Information</b-button>
      <br>
      <br>
 
        <br>
     

    </b-form>

      <br>
      <h3>Hosts for this event:</h3>
        <div v-for="host in hostsForThisEvent" v-bind:key="host.id">
            <span>{{ host.username }}</span><b-button  v-if="hasPermissionToDeleteEvent" v-on:click="removeHostFromEvent(host.id)" variant="warning" size="sm">Remove Host</b-button> 
            <!-- ADD REMOVE HOST button next to each host-->
            </div>
           <b-button v-if="hasPermissionToDeleteEvent" v-on:click="showHostForm">Add Host(s)</b-button>
    <div v-show="isHostFormShown" class="select-host-form">
        <b-alert v-model="showDismissibleAlertForHostUpdate" variant="success" fade dismissible>
        Successfully Updated Host
        </b-alert>
        <label class="typo__label">Select Host(s)</label>
         <multiselect v-model="value" :options="filteredDownHosts" :multiple="true" label="username" track-by="username" placeholder="Select Host(s)"></multiselect>
        <br>
         <b-button v-on:click="updateHosts" variant="primary">Add Hosts</b-button>
    </div>
      
          <div v-if="hasPermissionToDeleteEvent">
       
          <b-button class="fixed-bottom" variant="danger" size="sm" v-on:click="deleteEvent()">DELETE this Event</b-button>
    </div>
</b-col>
    
  </b-row>
</b-container>

  </div>
</template>

<script>
import eventService from '../services/EventService.js'
import hostService from '../services/HostService.js'
import Multiselect from 'vue-multiselect'
import genreService from '../services/GenreService.js'
import songService from '../services/SongService.js'

 
export default {
    name: 'EditEvent',
    components: {Multiselect, },
    data(){
        return {
            isFormDataLoaded: false,
            form: {},
            showDismissibleAlert: false,
            showDismissibleAlertForHostUpdate: false,
            showDismissibleAlertForGenreUpdate: false,
            value: [],
            allHosts: [],
            hostOptions: [], //todo filter this DOWN to remove the hosts currently selected for this event
            //options: [{"username":"lilebbiestatic", "id":5}, {"username":"lilhostystatic", "id":6}],
            isHostFormShown: false,
            hostsForThisEvent: [],
            genres: [], // filter the selectable genres from the active Genres
            genreValue: [],
            genresForThisEvent: [],
            filteredDownHosts: []
        }
    },
    computed: {
         hasPermissionToDeleteEvent(){
            if(this.$store.state.token == ''){
                return false;
            }else if(this.$store.state.user.authorities[0].name == 'ROLE_DJ' && this.$store.state.user.id == this.form.userId){
                return true;
            } else {
                return false;
            }
        },
    },
    methods: {
        onSubmit(event){
            event.preventDefault()
            // const editedEvent = this.form;
            // editedEvent.hostId
            // pass eventID

            // this is a redundant? passing form and form.id, the method could get the id from the object
            eventService.updateEvent(this.form.id, this.form)

            // a message back to the user that the event was updated successfully
            this.showDismissibleAlert = true;

        },
        deleteEvent(){
            if(confirm("Are you sure you want to delete this event PERMANENTLY?")){
               eventService.deleteEventById(this.form.id)
                .then(()=> {
                    // console.log(response)
                    this.$router.push("/");
                })
            }},
        showHostForm(){
            this.isHostFormShown = true;
        },
        updateHosts(){
            const hostIdArray = [];
            this.value.forEach((selectedHost) => {
                hostIdArray.push(selectedHost.id)
            })
            hostService.updateHostsOnEvent(this.$route.params.id, hostIdArray)
                .then(() => 
                //   console.log(response))
                  this.showDismissibleAlertForHostUpdate = true
                )
        },
        updateGenres(){
            // console.log(this.$route.params.id)
            // console.log(this.genreValue);
            genreService.addGenresToEvent(this.$route.params.id, this.genreValue)
                .then( (response) => {
                    // console.log(response.data)
                    const genresForThisEvent = response.data;
                    this.showDismissibleAlertForGenreUpdate = true;
                    songService.addSongsToEventPlaylistByGenresThatWereAddedAlready(this.$route.params.id, this.form.userId, genresForThisEvent)
                        .then(() => {
                            this.$router.push({name:'event', params:{id:this.form.id}})
                        })
                    })
        },
        removeHostFromEvent(hostId){
            
                if(confirm("Are you sure you want to remove this host?")){
                    // this eventService method doesn't exist yet ?
                     eventService.removeHostFromEvent(this.event.id, hostId)
                        .then((response) => console.log(response))
                        this.$router.go()
                }
            }
     
    },
    created(){
        // get the event data and load it in
        eventService.getEventById(this.$route.params.id)
            .then((response) => {
                this.form = response.data;
                this.isFormDataLoaded = true;
                const eventData = response.data;
                genreService.getGenresByDj(eventData.userId)
                    .then((response) => {
                        this.genres = response.data
                    }
                    
            )
            });
            
            // This gets ALL hosts
         hostService.getHosts()
            .then((response) => {
                // console.log(response.data)
                const hostObjects = response.data;



                // console.log(hostObjects)
                hostObjects.forEach((host) => {
                    
                    const hostObject = {};
                    hostObject.id = host.id;
                    hostObject.username = host.username;
                    // getting current hosts
                    this.allHosts.push(hostObject);

                });
                hostService.getHostsByEventId(this.$route.params.id)
                .then((response) => {
                this.hostsForThisEvent = response.data;
                const hostsForThis = response.data;
                
                const filteredHosts = this.allHosts.filter((element) => {
                    return !hostsForThis.find((element2) => {
                        return element.id === element2.id;
                    })
                });
                this.filteredDownHosts = filteredHosts;
            });
            });
            // this gets hosts for THIS event
        
        genreService.getGenresByEvent(this.$route.params.id)
            .then((response) => {
                this.genresForThisEvent = response.data;
            })
        
    }

}
</script>

<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
<style scoped>
    .information-form {
        border: black 2px solid;
    }

    .select-host-form {
        border: blue 2px solid;
    }

    .event-edit{
        height: 100vh;
        background-color: #090531;
        color: white;
        font-family: "Audiowide", sans-serif;
        text-align: center;
    }


</style>