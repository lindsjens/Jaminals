import axios from 'axios';

export default {
    getEvents() {
        return axios.get('/events')
    },

    getEventById(id){
        return axios.get(`/events/${id}`)

    },

    createEvent(newEvent){
        return axios.post('/events', newEvent)
    },

    deleteEventById(id){
        return axios.delete(`/events/${id}`)
    },
        
    getEventsByDjID(id){
        return axios.get(`/dj/${id}/events`)
    },

    updateEvent(id, event){
        return axios.put(`/events/${id}`, event)
    },
    getEventsByHostId(id){
        return axios.get(`/events/host/${id}`)
    },

    removeHostFromEvent(hostId){
        return axios.delete(`/events/${hostId}`)
    },

    


}