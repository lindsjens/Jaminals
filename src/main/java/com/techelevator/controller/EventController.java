package com.techelevator.controller;


import com.techelevator.dao.EventDao;
import com.techelevator.dao.EventHostDao;
import com.techelevator.dao.GenreDao;
import com.techelevator.dao.JdbcEventHostDao;
import com.techelevator.model.Event;
import com.techelevator.model.EventHost;
import com.techelevator.model.EventNotFoundException;
import com.techelevator.model.Genre;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@CrossOrigin
@PreAuthorize("isAuthenticated()")
public class EventController {

    /*******************************************************************************************************************
      This Controller is for returning Event objects such as events or event details
    *******************************************************************************************************************/

    private EventDao eventDao;
    private EventHostDao eventHostDao;
    private GenreDao genreDao;

    public EventController(EventDao eventDao, EventHostDao eventHostDao, GenreDao genreDao){
        this.eventDao = eventDao;
        this.eventHostDao = eventHostDao;
        this.genreDao = genreDao;
    }

    /*******************************************************************************************************************
      Unauthorized Guest:
    *******************************************************************************************************************/

    //as an unauthorized guest, I need to view a list of events
    @PreAuthorize("permitAll")
    @RequestMapping(value="/events", method = RequestMethod.GET)
    public List<Event> getAllEvents(){
        return eventDao.listOfEvents();
    }

    //as an authorized dj, I need to view a list of my events
    @PreAuthorize("hasRole('DJ')")
    @RequestMapping(value="/dj/{id}/events", method = RequestMethod.GET)
    public List<Event> getEventsByUserId(@PathVariable Long id){
        return eventDao.eventsByDjId(id);
    }

    //as an unauthorized guest, I need to view a specific event
    @PreAuthorize("permitAll")
    @RequestMapping(value="/events/{id}", method = RequestMethod.GET)
    public Event selectedEvent(@PathVariable Long id) throws EventNotFoundException {
        return eventDao.getEventById(id); //insert method here
    }

    //as an authorized host/DJ, I need to view a list of genres for an event
    @PreAuthorize("permitAll")
    @RequestMapping(value="/events/{id}/genres", method = RequestMethod.GET)
    public List<Genre> listOfEventGenres(@PathVariable Long id) {
        return genreDao.eventGenres(id);
    }

    /*******************************************************************************************************************
      Authorized Dj or Host
    *******************************************************************************************************************/

    //as a host, I need to view my events (doesn't need auth)
    @PreAuthorize("permitAll")
    @RequestMapping(value="/events/host/{id}", method = RequestMethod.GET)
    public List<Event> getEventsByHostId(@PathVariable Long id){
        return eventDao.eventsByHostId(id);
    }


    // As a Host or Dj I need to be able to set the event genres

    @PreAuthorize("hasAnyRole('DJ','HOST')")
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value="/events/{id}/genres", method = RequestMethod.POST)
    public List<Genre> addGenreToEvent(@PathVariable Long id, @Valid @RequestBody List<Genre> genreList){
        return genreDao.genreForEvent(id, genreList);
    }

    /*******************************************************************************************************************
      Authorized Dj: ONE MORE ENDPOINT TO FIX
    *******************************************************************************************************************/

    //as an authorized DJ, I need to be able to create an event
    @PreAuthorize("hasRole('DJ')")
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "/events", method= RequestMethod.POST)
    public Event createEvent(@Valid @RequestBody Event event) throws EventNotFoundException {
        return eventDao.create(event);
    }

    //as an authorized DJ, I need to be able to delete an event
    @PreAuthorize("permitAll")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(value = "/events/{id}", method= RequestMethod.DELETE)
    public void deleteEvent(@PathVariable Long id) {
         eventDao.deleteEvent(id);
    }

    //as an authorized DJ, I need to be able to update an event
    @PreAuthorize("hasAnyRole('DJ','HOST')")
    @RequestMapping(value="/events/{id}", method = RequestMethod.PUT)
    public Event updateEvent(@RequestBody Event event, @PathVariable Long id) throws EventNotFoundException{
        return eventDao.updateEvent(event, id);
    }

    //as an authorized DJ, I need to be able to create an event
    @PreAuthorize("hasRole('DJ')")
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value="/events/{id}/hosts", method = RequestMethod.POST)
    public Event addHostsToEvent(@PathVariable Long id, @Valid @RequestBody List<Long> hosts) throws EventNotFoundException {
        return eventDao.addHost(id, hosts);
    }

    //todo -> as an authorized DJ, I need to be able to remove a host from an event
    //currently does not work
    @PreAuthorize("hasRole('DJ')")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(value="/events/{id}/{hosts}", method = RequestMethod.DELETE)
    public void deleteHostFromEvent(@Valid @PathVariable("id") Long eventId, @PathVariable("hosts") Long userId) {
        eventHostDao.deleteHostFromEvent(eventId,userId);
    }


}