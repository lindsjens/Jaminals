package com.techelevator.dao;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;

@Component
@CrossOrigin
public class JdbcSongGenreDao implements SongGenreDao{

    private JdbcTemplate jdbcTemplate;

    public JdbcSongGenreDao(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    //update GENRE'S SONGS
    //String sql = "UPDATE song_genre SET song_id = ? WHERE genre_id = ?;";

    //delete all songs from selected genre


}
