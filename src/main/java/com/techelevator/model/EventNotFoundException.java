package com.techelevator.model;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code= HttpStatus.NOT_FOUND, reason = "Event Not Found")
public class EventNotFoundException extends Exception{

    public EventNotFoundException(){
        super("Event Not Found");
    }

}
