<template>
  <div>
      <div v-if="dj">
          <b-container class="dj-songs">
              <h4>
                Featuring {{dj.username}} 
              </h4>
              <p class="click-instructions">Click to add song from this DJ's library that is not yet in the playlist to the event playlist</p>
        <b-table class="Table dj-library"  striped hover :items="filteredDjSongs" :fields="fields"  @row-clicked="songRowClickHandler"></b-table>
      </b-container>
      </div>
      
     
  </div>
</template>

<script>
import songService from '../services/SongService.js'

export default {
    name: 'ViewAddDjSongsToEvent',
    props:['dj', 'eventSongs'],

    data(){
        return {
            fields: [{key: 'artistName', sortable:true}, {key: 'name', sortable:true} ],
            allDjSongs: [], // filter out what is already in the event playlist
            filteredDjSongs: [],
            
        }
    },
    // computed: {
    //     songsNotInEventFromDjLibrary(){
    //         let res = [];
    //         res = this.allDjSongs.filter((element) => {
    //             return !this.eventSongs.find((element2) => {
    //                 return element.id === element2.id;
    //             });
    //         });
    //         return res;
            
    //     }
    // },
    created(){
        songService.getSongsByDjId(this.dj.id)
            .then((response) => {
                // console.log("trying to get songs by dj:")
                // console.log(response.data)
                
                // this.allDjSongs = response.data;
                const allDjSongsResponse = response.data;
                const filteredSongs = allDjSongsResponse.filter((element) => {
                return !this.eventSongs.find((element2) => {
                    return element.id === element2.id;
                });
                
            });
                this.filteredDjSongs = filteredSongs;
            })
    },
    methods: {
        songRowClickHandler(record){
            if(confirm("Add " + record.name + " by " + record.artistName + " to the event playlist" )){
                // console.log(record.name + " will be added")
                // console.log(this.$route.params.id)
                // console.log(record.id)
                const requestBody = {};
                requestBody.eventId = this.$route.params.id;
                requestBody.songId = record.id;
                songService.addSongToEventPlaylist(requestBody)
                    .then(() => {
                       this.$router.go()
                        
                    })
            }
            
        }
    }
    
}
</script>

<style scoped>
.dj-songs {
    color: white;
}


.dj-library tr {
    cursor: pointer;
}

.click-instructions {
    color:yellow;
}

</style>