package com.techelevator.model;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.I_AM_A_TEAPOT, reason ="Song is already in Library")
public class SongAlreadyExistsException extends Exception{

    public SongAlreadyExistsException(){
        super("Song is Already in Library");
    }
}
