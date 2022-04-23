import axios from 'axios';

export default {
    getGenresByDj(id) {
        return axios.get(`/dj/${id}/genres`)
    },

    getGenresByEvent(id){
        return axios.get(`/events/${id}/genres`)
    },

    addGenresToEvent(id, genres){
        return axios.post(`/events/${id}/genres`, genres)
    }


    


}



