SELECT *
FROM users

SELECT *
FROM artist

SELECT *
FROM song

SELECT *
FROM genre

SELECT *
FROM dj_library

SELECT *
FROM event

SELECT song_id, song_name, artist_name, featured_artist
FROM song
NATURAL JOIN dj_library
NATURAL JOIN users
WHERE dj_library.user_id = 3
ORDER BY song_id ASC;

SELECT user_id, username
FROM users
WHERE role = 'ROLE_DJ';

--query to look up song in dj library to add to playlist--
SELECT song_name, artist_name
FROM song
NATURAL JOIN dj_library
WHERE song_name ILIKE '%e%';

SELECT song_id, song_name, artist_name, featured_artist
FROM song
NATURAL JOIN event_song
WHERE event_id = 3;

--select all song names with id's and genres--
SELECT song.song_name, song.song_id, genre_name FROM  song
JOIN song_genre ON song.song_id = song_genre.song_id

--DELETE STATEMENTS--

>Delete all songs of a selected genre from the dj_library:
DELETE FROM dj_library 
WHERE dj_library.song_id IN  
	(SELECT song_id
		FROM song_genre
		WHERE genre_name = '?')
	AND user_id = ?;

>Delete host from event:
DELETE FROM event_host
WHERE user_id = ? AND event_id = ?;

--PUT/UPDATE STATEMENTS--

>update genre of song:
UPDATE song_genre SET song_id = ? WHERE genre_id = ?;

--POST/CREATE STATEMENTS--

>add song from dj_library into event playlist:
DO $$
BEGIN
IF NOT (SELECT EXISTS (SELECT 1 FROM event_song WHERE song_id=50)) THEN
INSERT INTO event_song (event_id, song_id)
VALUES (4,50);
END IF;
END $$;

>add all songs of selected genre to playlist:
INSERT INTO dj_library (user_id, song_id)
SELECT 6 id, x
FROM unnest(ARRAY(
SELECT song_id
FROM song_genre
WHERE genre_name = 'pop')) x;
