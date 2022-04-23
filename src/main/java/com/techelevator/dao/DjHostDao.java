package com.techelevator.dao;

import com.techelevator.model.EventHost;
import com.techelevator.model.User;

import java.util.List;

public interface DjHostDao {

    List<User> listOfDjs();
    List<User> listOfHosts();
    List<User> hostsForEvent(Long eventId);
}
