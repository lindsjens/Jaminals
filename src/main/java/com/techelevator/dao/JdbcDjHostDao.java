package com.techelevator.dao;


import com.techelevator.model.EventHost;
import com.techelevator.model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.ArrayList;
import java.util.List;

@Component
@CrossOrigin
public class JdbcDjHostDao implements DjHostDao{

    private JdbcTemplate jdbcTemplate;

    public JdbcDjHostDao(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public List<User> listOfDjs() {
        List<User> djs = new ArrayList<>();

        String sql = "SELECT user_id, username\n" +
                "FROM users\n" +
                "WHERE role = 'ROLE_DJ'\n" +
                "ORDER BY user_id ASC;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()) {
            djs.add(mapRowToUser(results));
        }
        return djs;
    }

    @Override
    public List<User> listOfHosts() {
        List<User> hosts = new ArrayList<>();

        String sql = "SELECT user_id, username\n" +
                "FROM users\n" +
                "WHERE role = 'ROLE_HOST'\n" +
                "ORDER BY user_id ASC;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while (results.next()) {
            hosts.add(mapRowToUser(results));
        }
        return hosts;
    }

    @Override
    public List<User> hostsForEvent(Long eventId) {
        List<User> hosts = new ArrayList<>();

        String sql = "SELECT user_id, username\n" +
                "FROM users\n" +
                "NATURAL JOIN event_host\n" +
                "WHERE event_id = ?;";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, eventId);
        while (results.next()) {
            hosts.add(mapRowToUser(results));
        }
        return hosts;

    }

    private User mapRowToUser(SqlRowSet rs) {
        User user = new User();
        user.setId(rs.getLong("user_id"));
        user.setUsername(rs.getString("username"));
        return user;
    }
}
