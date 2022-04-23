package com.techelevator.dao;

import com.techelevator.model.Event;
import com.techelevator.model.EventNotFoundException;
import com.techelevator.model.Genre;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.List;

public interface EventDao {

    List<Event> listOfEvents();
    Event getEventById(Long id) throws EventNotFoundException;
    Event create(Event event) throws EventNotFoundException;
    void deleteEvent(Long id);
    Event addHost(Long eventId, List<Long> hosts) throws EventNotFoundException;
    Event updateEvent(Event event, Long id) throws EventNotFoundException;
    List<Event> eventsByDjId(Long id);
    List<Event> eventsByHostId(Long id);
}
