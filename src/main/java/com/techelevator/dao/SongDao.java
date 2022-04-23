package com.techelevator.dao;

import com.techelevator.model.*;

import java.util.List;

public interface SongDao {

    List<Song> djSongList(Long id);
    List<Song> eventPlaylist(Long id);
    EventSong submitSong(EventSong eventSong);
    void deleteSongFromLibrary(Long userId, Long songId);
    Song addSong(Long id, Long userId);
    List<Song> addSongsFromGenreToDjLibrary(String name, Long id);
    List<Song> addSongsFromGenreToEventPlaylist(Long djId, Long eventId, List<Genre> genreList);
}

