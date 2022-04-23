package com.techelevator.model;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class Event {

    private Long id;
    private Long userId;

    private String name;
    private String information;

    //    private List<Long> hostId;

    public Long getId() {return id;}
    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {return name;}
    public void setName(String name) {
        this.name = name;
    }

    public String getInformation() {return information;}
    public void setInformation(String information) {
        this.information = information;
    }

    public Long getUserId() {return userId;}
    public void setUserId(Long userId) {
        this.userId = userId;
    }

//    public List<Long> getHostId() {
//        return hostId;
//    }
//    public void setHostId(Long id) {
//        this.hostId.add(id);
//    }

    //todo also represent the photo at some point


}