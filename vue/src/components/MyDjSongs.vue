<template>
  <div>
      <h2>{{this.$store.state.user.username}}'s Library</h2>
      
      <b-container class="dj=songs">
        <b-table class="Table"  striped hover :items="songs" :fields="fields"></b-table>
      </b-container>
      </div>
  
</template>

<script>
import songService from '../services/SongService.js'

export default {
    name: 'MyDjSongs',
    data() {
        return {
            fields: ['artistName', 'name'],
            songs:null,
        }
    },
    created(){
        // put a prop inside the parameter
        songService.getSongsByDjId(this.$store.state.user.id)
        .then((response) => {
            console.log(response)
            this.songs = response.data;
            console.log(response)
        })
    }
}
</script>

<style scoped>
.dj-songs {
    color: white;
    background-color: #090531;
}
.Table{
    background-color: #01F8E9;
}


</style>