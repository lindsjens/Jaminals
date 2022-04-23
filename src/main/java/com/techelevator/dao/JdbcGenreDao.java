package com.techelevator.dao;


import com.techelevator.model.Genre;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Component
@CrossOrigin
public class JdbcGenreDao implements GenreDao{

    private JdbcTemplate jdbcTemplate;

    public JdbcGenreDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }



    @Override
    public List<Genre> listOfDjLibraryGenres(Long id) {
        List<Genre> genreList = new ArrayList<>();

        String sql = "SELECT DISTINCT genre_name\n" +
                "FROM song_genre\n" +
                "NATURAL JOIN song\n" +
                "NATURAL JOIN dj_library\n" +
                "WHERE user_id = ? AND song_genre.song_id = dj_library.song_id;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
        while (results.next()) {
            genreList.add(mapRowToGenre(results));
        }

        return genreList;
    }

    @Override
    public List<Genre> eventGenres(Long id) {
        List<Genre> genreList = new ArrayList<>();

        String sql = "SELECT DISTINCT genre_name " +
                "FROM event_genre " +
                "WHERE event_id = ?;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
        while (results.next()) {
            genreList.add(mapRowToGenre(results));
        }

        return genreList;
    }


    private Genre mapRowToGenre(SqlRowSet rowSet) {
        Genre g = new Genre();

        g.setName(rowSet.getString("genre_name"));

        return g;
    }

    @Override
    public List<Genre> genreForEvent(Long id, List<Genre> genreList) {

        String sql = "INSERT INTO event_genre(event_id, genre_name)\n" +
                "VALUES (?, ?);";

        jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
            @Override
            public void setValues(PreparedStatement ps, int i) throws SQLException {
                Genre genre = genreList.get(i);
                String genreName = genre.getName();
                ps.setLong(1, id);
                ps.setString(2, genreName);
            }

            @Override
            public int getBatchSize() {
                return genreList.size();
            }
        });

        return eventGenres(id);
    }

}
