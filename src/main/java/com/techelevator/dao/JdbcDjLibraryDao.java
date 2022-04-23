package com.techelevator.dao;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;

@Component
@CrossOrigin
public class JdbcDjLibraryDao implements DjLibraryDao{

    private JdbcTemplate jdbcTemplate;

    public JdbcDjLibraryDao(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }



    //ADD SONG TO EVENT PLAYLIST
//    DO $$
//    BEGIN
//    IF NOT (SELECT EXISTS (SELECT 1 FROM event_song WHERE song_id=50)) THEN
//    INSERT INTO event_song (event_id, song_id)
//    VALUES (4,50);
//    END IF;
//    END $$;

//DELETE ALL  SONGS FROM A GENRE
//    String sql  = "DELETE FROM dj_library\n" +
//            "\t\t\tWHERE user_id = 3\n" +
//            "\t\t\tAND song_id IN (SELECT song_id\n" +
//            "\t\t\tFROM song_genre\n" +
//            "\t\t\tWHERE genre_name = 'pop')"




}
