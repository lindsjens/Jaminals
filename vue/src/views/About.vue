<template>
   <div class="about">
        <img src="..\images\jampinktransp.png" />

         <b-container class="bv-example-row">
      <b-row>
        <b-col>
          <div class="deserae">
            <img class="mx-auto d-block dolphin" src="..\images\JamDolph.png" />
            <h2 class = "name"> Deserae </h2>
            <h3 class = "about">Deserae is a local legend who belonged to multiple sororities while in college and none of them knew about the others.</h3>
          </div>
        </b-col>
        <b-col><div class="lily">
          <center>
          <img class="mx-auto d-block cow"  src="..\images\LilyJamCow.png" />
          </center>
        <h2 class = "name"> Lily </h2>
        <h3 class = "about">Lily once threw a rager in a Dick's Sporting Goods that was written up in a local paper.</h3>
        </div></b-col>
      </b-row>
       <b-row>
        <b-col>
          <div class="lindsey">
            <img class="mx-auto d-block seahorse" src="..\images\SeahorseJamLindsey.png" />
            <h2 class = "name"> Lindsey </h2>
            <h3 class = "about">Lindsey asked Nic Cage to show up to her birthday one year... and he actually did.</h3>
            </div>
        </b-col>
        <b-col><div class="scott">
          <img class="mx-auto d-block beta" src="..\images\BetaPurpBlueLogo.png" />
        <h2 class = "name"> Scott </h2>
        <h3 class = "about">Scott threw a party in three states at the same time and when the cops showed up, they joined the party... it was that good.</h3>
        </div></b-col>
      </b-row>
</b-container>
    </div>
      
</template>

<script>
export default {
    name: "About",
}
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Neonderthaw&display=swap');
.about{
  background-color: #090531;
  color: white;
  font-family: "Audiowide", sans-serif;
  text-align: center;
}
.name{
  font-family: "Neonderthaw";
  text-align: center;
  color: 0278E4;
  font-size: 100px;
}
.deserae{
    border:#003B77 5px solid;
    padding: 5px;
    border-radius: 10px;
    background-color: #01F8E9;
}
.lily{
    border:#003B77 5px solid;
    padding: 5px;
    border-radius: 10px;
    background-color: #FC05F4;
}
.lindsey{
    background-color: #01F8E9;
    border:#003B77 5px solid;
    padding: 5px;
    border-radius: 10px;
    background-color: #FC05F4;
}
.scott{
    border:#003B77 5px solid;
    padding: 5px;
    border-radius: 10px;
    background-color: #01F8E9;
   
}
.dolphin{
  max-height: 350px;
  
}
.beta{
  max-height: 350px;
}
.cow{
   max-height: 350px;
   
}
.seahorse {
  max-height: 350px;
}

.about{
  font-family: "Audiowide";
}
</style>
