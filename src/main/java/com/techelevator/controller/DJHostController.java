package com.techelevator.controller;

import com.techelevator.dao.DjHostDao;
import com.techelevator.model.EventHost;
import com.techelevator.model.User;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@PreAuthorize("isAuthenticated()")
public class DJHostController {

    /*******************************************************************************************************************
      This Controller is for returning objects that are users, such as DJ or Host
    *******************************************************************************************************************/

    private DjHostDao djHostDao;

    public DJHostController(DjHostDao djHostDao){
        this.djHostDao = djHostDao;
    }


    /*******************************************************************************************************************
      Unauthorized Guest:
    *******************************************************************************************************************/

    //as an unauthorized guest, I need to view a list of DJs
    @PreAuthorize("permitAll")
    @RequestMapping(value="/djs", method= RequestMethod.GET)
    public List<User> getListOfDjs() {
        return djHostDao.listOfDjs();
    }

    //as an unauthorized user, I need to see the hosts at an event
    @PreAuthorize("permitAll")
    @RequestMapping(value="/hosts/{id}", method = RequestMethod.GET)
    public List<User> getHostsForEvent(@PathVariable Long id){
        return djHostDao.hostsForEvent(id);
    }

    /*******************************************************************************************************************
      Authorized Dj
    *******************************************************************************************************************/

    //as a DJ, I need to view a list of all hosts
    @PreAuthorize("hasRole('DJ')")
    @RequestMapping(value="/hosts", method = RequestMethod.GET)
    public List<User> getListOfHosts(){
        return djHostDao.listOfHosts();
    }
}
