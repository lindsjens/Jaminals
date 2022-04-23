package com.techelevator.model;

public class EventHost {

    private Long eventId;
    private Long hostId;
    private String name;


    public Long getEventId(){
        return eventId;
    }
    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }

    public Long getHostId(){
        return hostId;
    }
    public void setHostId(Long hostId){
        this.hostId = hostId;
    }

    public String getName(){
        return this.name;
    }
    public void setName(String name) {
        this.name = name;
    }
}
