<template>
  <div class="create-event">
      <h2 class="head">Create an Event</h2>
      <div>
    <b-form @submit="onSubmit" @reset="onReset" v-if="show">
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

      <b-form-textarea
      id="input-information"
      v-model="form.information"
      placeholder="Enter event information..."
      rows="3"
      max-rows="6"
    ></b-form-textarea>

      <b-button type="submit" variant="primary">Submit</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
    </b-form>
    
  </div>
  </div>
</template>

<script>
import eventService from '../services/EventService.js'

export default {
    name: 'CreateEventForm',
    data() {
      return {
        hosts: [],
        form: {
          name: '',
          information: '',
          userId: null
        },
        show: true
      }
    },
    methods: {
      onSubmit(event) {
        event.preventDefault()
        const newEvent = this.form;
        newEvent.userId = this.$store.state.user.id
        eventService.createEvent(this.form)
            .then((response) => {
              this.$router.push({name: 'event', params: {id: response.data.id}})
            }

        )
        
        // alert(JSON.stringify(this.form))
      },
      onReset(event) {
        event.preventDefault()
        // Reset our form values
        this.form.name = ''
        this.form.information = ''
        // Trick to reset/clear native browser form validation state
        this.show = false
        this.$nextTick(() => {
          this.show = true
        })
      }
    },

}
</script>

<style>
.create-event{
    border:#003B77 5px solid;
    padding: 5px;
    border-radius: 10px;
    background-color: #01F8E9;
}
#input-name{
  font-family:sans-serif;
}
#input-information{
  font-family: sans-serif;
}
.head{
  font-family: "Audiowide";
}

</style>