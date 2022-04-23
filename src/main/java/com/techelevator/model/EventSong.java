package com.techelevator.model;

public class EventSong {

    //should we make this class inherit both Event and Song classes?
    //not sure if we need to keep it like this, or change it for simplicity.

    private Long eventId;
    private Long songId;


    public Long getEventId(){
        return eventId;
    }
    public void setEventId(Long eventId){
        this.eventId = eventId;
    }

    public Long getSongId(){
        return songId;
    }
    public void setSongId(Long songId){
        this.songId = songId;
    }
}
