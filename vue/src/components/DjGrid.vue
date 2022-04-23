<template>
  <div class="dj-grid">
      <h2>DJs</h2>
      <div v-for="dj in djs" v-bind:key="dj.id">
         <h3><router-link v-bind:to="{name:'dj',params: {id:dj.id, username: dj.username } }" >{{ dj.username }}</router-link></h3>
      </div>
  </div>
</template>

<script>

import djService from '../services/DJService.js'

export default {
    name: 'DjGrid',
    data(){
        return {
            djs: []
        }
    },
    created(){
        djService.getDjs()
        .then((response) => {
            this.djs = response.data;
            this.$store.state.djs = response.data;
        })
    }

}
</script>

<style scoped>
.dj-grid {
    border: #003B77 5px solid;
    border-radius: 10px;
    padding: 5px;
}
a{
    color: #003B77;
}

</style>