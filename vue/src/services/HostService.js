import axios from 'axios';

export default {
    getHosts() {
        return axios.get('/hosts')
    },

    getHostsByEventId(id) {
        return axios.get(`/hosts/${id}`)
    },

    updateHostsOnEvent(id, hostArray) {
        return axios.post(`/events/${id}/hosts`, hostArray)
    },

      // //TODO - finish this
    // removeHostFromEvent(eventId, hostId){
    //     return axios.delete()
    // }



}