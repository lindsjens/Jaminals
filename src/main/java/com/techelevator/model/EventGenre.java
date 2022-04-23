package com.techelevator.model;

public class EventGenre {

    private String genreName;
    private Long eventId;


    public String getGenreName(){
        return genreName;
    }
    public void setGenreName(String genreName) {
        this.genreName = genreName;
    }

    public Long getEventId() {
        return eventId;
    }
    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }
}
