<template>
  <div class="dj-home">
      <b-container>
      <h1>DJ page</h1>
      <h2>{{ this.$store.state.user.username }}</h2>
      <h3>My songs:</h3>
      <b-table striped hover :items="songs" :fields="fields"></b-table>
      <create-event-form />
      </b-container>
        

  </div>
</template>

<script>
import songService from '../services/SongService.js'
import CreateEventForm from '../components/CreateEventForm.vue'

export default {
  components: { CreateEventForm },
    
    name: 'HostHome',
    data(){
        return {
            fields: ['artistName', 'name'],
            songs: null
        }
    },
    created(){
        songService.getSongsByDjId(this.$store.state.user.id)
        .then((response) => {
            console.log(response)
            this.songs = response.data;
        })
    }

}
</script>

<style scoped>
    h2 {
        color: rgb(255, 166, 0)
    }

    .dj-home{
      background-color: #090531;
}

</style>