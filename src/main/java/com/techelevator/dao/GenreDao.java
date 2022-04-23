package com.techelevator.dao;

import com.techelevator.model.Genre;

import java.util.List;

public interface GenreDao {

    //method to return list of genres in dj library

    List<Genre> listOfDjLibraryGenres(Long id);
    List<Genre> eventGenres(Long id);
    List<Genre> genreForEvent(Long id, List<Genre> genreList);
}
