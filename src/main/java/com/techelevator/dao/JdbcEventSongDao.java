package com.techelevator.dao;

import com.techelevator.model.EventSong;
import com.techelevator.model.Song;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;


@Component
@CrossOrigin
public class JdbcEventSongDao implements EventSongDao{

    private JdbcTemplate jdbcTemplate;

    public JdbcEventSongDao(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }



    private EventSong mapRowToEvent(SqlRowSet rowSet){
        EventSong es = new EventSong();

        es.setEventId(rowSet.getLong("event_id"));
        es.setSongId(rowSet.getLong("song_id"));

        return es;
    }
}
