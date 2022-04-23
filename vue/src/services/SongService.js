import axios from 'axios';

export default {
    getSongsByDjId(id){
        return axios.get(`/djs/${id}/songs`)

    },

    getSongsByEvent(eventId){
        return axios.get(`/events/${eventId}/songs`)
    },

    addSongToEventPlaylist(requestBody) {
        return axios.post('/events/songs', requestBody)
    },

    addSongsToEventPlaylistByGenresThatWereAddedAlready(eventId, djId, genres){
        return axios.post(`/event/${eventId}/dj/${djId}/genres/songs`, genres)
    }


}