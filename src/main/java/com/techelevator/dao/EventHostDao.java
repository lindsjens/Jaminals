package com.techelevator.dao;

import com.techelevator.model.Event;
import com.techelevator.model.EventHost;

public interface EventHostDao {

void deleteHostFromEvent(Long eventId, Long userId);
}
