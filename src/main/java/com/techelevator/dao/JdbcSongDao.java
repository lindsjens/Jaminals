package com.techelevator.dao;

import com.techelevator.model.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;

import javax.sql.RowSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@Component
@CrossOrigin
public class JdbcSongDao implements SongDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcSongDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Song> djSongList(Long id) {
        List<Song> songs = new ArrayList<>();

        String sql = "SELECT song_id, song_name, artist_name, featured_artist\n" +
                "FROM song\n" +
                "NATURAL JOIN dj_library \n" +
                "NATURAL JOIN users \n" +
                "WHERE dj_library.user_id = ?" +
                "ORDER BY song_id ASC;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
        while (results.next()) {
            songs.add(mapRowToSong(results));
        }
        return songs;
    }


    @Override
    public List<Song> eventPlaylist(Long id) {
        List<Song> eventPlaylistSongs = new ArrayList<>();

        String sql = "SELECT song_id, song_name, artist_name, featured_artist\n" +
                "FROM song\n" +
                "NATURAL JOIN event_song\n" +
                "WHERE event_id = ?;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
        while (results.next()) {
            eventPlaylistSongs.add(mapRowToSong(results));
        }

        return eventPlaylistSongs;
    }

    @Override
    public EventSong submitSong(EventSong e) {
        EventSong s = new EventSong();


        String sql = "INSERT INTO event_song(event_id, song_id) " +
                "VALUES (?, ?);";

        try {
            jdbcTemplate.update(sql, e.getEventId(), e.getSongId());
            s.setSongId(e.getSongId());
            s.setEventId(e.getEventId());
        } catch (Exception exception) {
            System.out.println("You cannot add a duplicate Song");
        }

        return s;
    }



    @Override
    public void deleteSongFromLibrary(Long songId, Long userId) {
        String sql = "DELETE FROM dj_library " +
                "WHERE user_id = ? AND song_id = ?;";

        int numRows = jdbcTemplate.update(sql, userId, songId);
    }

    @Override
    public Song addSong(Long id, Long userId) {
        Song addedSong = new Song();

        String sql = "INSERT INTO dj_library (user_id, song_id) " +
                "VALUES (?,?);";

        try {
            jdbcTemplate.update(sql, userId, id);
            addedSong.setId(id);
        } catch (Exception e) {
            System.out.println("Do Not Add Repeat Songs");
        }

        return addedSong;

    }

    @Override
    public List<Song> addSongsFromGenreToDjLibrary(String name, Long id) {

        String sqlA = "SELECT song_id \n" +
                "FROM song\n" +
                "NATURAL JOIN song_genre\n" +
                "WHERE genre_name = ?";


        List<Long> songsInGenre = new ArrayList<>();

        SqlRowSet resultsA = jdbcTemplate.queryForRowSet(sqlA, name);
        while (resultsA.next()) {
            songsInGenre.add(resultsA.getLong("song_id"));
        }

        String sqlB = "SELECT song_id \n" +
                "FROM dj_library \n" +
                "WHERE user_id = ?;";


        List<Long> existingSongsInLibrary = new ArrayList<>();

        SqlRowSet resultsB = jdbcTemplate.queryForRowSet(sqlB, id);
        while (resultsB.next()) {
            existingSongsInLibrary.add(resultsB.getLong("song_id"));
        }

        HashSet<Long> existingSongs = new HashSet<>(existingSongsInLibrary);
        List<Long> songsToAdd = new ArrayList<>();

        for (Long song: songsInGenre) {
            if (!existingSongs.contains(song)){
                songsToAdd.add(song);
            }
        }


        String sql = "INSERT INTO dj_library(user_id, song_id)\n" +
                "VALUES (?, ?);";

        jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                Long songId = songsToAdd.get(i);
                ps.setLong(1, id);
                ps.setLong(2, songId);
            }

            @Override
            public int getBatchSize() {
                return songsToAdd.size();
            }
        });

        return djSongList(id);
    }

    @Override
    public List<Song> addSongsFromGenreToEventPlaylist(Long djId, Long eventId, List<Genre> genreList) {
        List<Song> eventSongList = new ArrayList<>();

        List<Song> songsInGenresAndDjLibrary = new ArrayList<>();
        //Create List of all songs from DJ list and genre
        String baseSql = "SELECT DISTINCT on (song_id) song.song_id, artist_name, song_name, featured_artist, song_genre.genre_name\n" +
                "FROM dj_library\n" +
                "INNER JOIN song on dj_library.song_id = song.song_id\n" +
                "INNER JOIN event on event.user_id = dj_library.user_id\n" +
                "INNER JOIN event_genre on event_genre.event_id = event.event_id\n" +
                "INNER JOIN song_genre on song_genre.song_id = song.song_id\n" +
                "WHERE dj_library.user_id = ? AND song_genre.genre_name = ";

        String additionalGenreSql = "'" + genreList.get(0).getName() +"'";
        if(genreList.size()>1){
            for (int i = 1; i< genreList.size(); i++) {
                additionalGenreSql += "OR genre_name = '" + genreList.get(i).getName() + "'";
            }
        }
        String allSQL = baseSql+additionalGenreSql;
        SqlRowSet results = jdbcTemplate.queryForRowSet(allSQL, djId);
        while (results.next()){
            songsInGenresAndDjLibrary.add(mapRowToSong(results));
        }

        String sqlInsert = "INSERT INTO event_song(event_id, song_id) " +
                "VALUES (?, ?) ON CONFLICT (event_id, song_id) DO NOTHING";

        jdbcTemplate.batchUpdate(sqlInsert, new BatchPreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                Long songId = songsInGenresAndDjLibrary.get(i).getId();
                ps.setLong(1, eventId);
                ps.setLong(2, songId);

            }

            @Override
            public int getBatchSize() {
                return songsInGenresAndDjLibrary.size();
            }
        });

        return eventPlaylist(eventId);
    }


    private Song mapRowToSong(SqlRowSet rowSet){
        Song s = new Song();

        s.setId(rowSet.getLong("song_id"));
        s.setName(rowSet.getString("song_name"));
        s.setArtistName(rowSet.getString("artist_name"));
        s.setFeatured(rowSet.getString("featured_artist"));

        return s;
    }

    private DjLibrary mapRowToSongEvent(SqlRowSet rowSet){
        DjLibrary djSong = new DjLibrary();

        djSong.setUserId(rowSet.getLong("user_id"));
        djSong.setSongId(rowSet.getLong("song_id"));

        return djSong;
    }

}