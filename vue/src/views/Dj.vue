<template>

  <div class="DJ">
      <b-container>
      <h2>I am DJ: {{ this.$route.params.username }}</h2>
      <h2 class="Table">My songs:</h2>
      <b-table class="Table" striped hover :items="songs" :fields="fields"></b-table>
      </b-container>
  </div>
</template>

<script>
import songService from '../services/SongService.js'

export default {
    name: 'Dj',
    data(){
        return {
            fields: ['artistName', 'name'],
            songs: null
        }
    },
    created(){
        songService.getSongsByDjId(this.$route.params.id)
        .then((response) => {
            console.log(response)
            this.songs = response.data;
        })
    }

}

</script>

<style scoped>
.DJ{
    background-color: #090531;
    color: white;
    font-family: "Audiowide", sans-serif;
}

    .dj-songs {
        display:flex;
        width: 50%;
    }

</style>