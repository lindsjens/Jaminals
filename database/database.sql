BEGIN TRANSACTION;


DROP TABLE IF EXISTS event_song;
DROP TABLE IF EXISTS dj_library;
DROP TABLE IF EXISTS song_genre;
DROP TABLE IF EXISTS event_genre;
DROP TABLE IF EXISTS event_host;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS users;



DROP SEQUENCE IF EXISTS seq_user_id;


CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) UNIQUE NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

--start of our tables
CREATE TABLE genre(
	genre_name varchar(64),
	CONSTRAINT PK_genre PRIMARY KEY (genre_name)
);
CREATE TABLE artist (
	artist_name varchar(64),
	CONSTRAINT PK_artist PRIMARY KEY (artist_name)
);
CREATE TABLE event (
	event_id serial NOT NULL,
	user_id int NOT NULL, 
	event_name varchar(100),
	information varchar(512),
	picture bytea,
	
	CONSTRAINT PK_event PRIMARY KEY (event_id),
	CONSTRAINT FK_event_user_id FOREIGN KEY (user_id) REFERENCES users(user_id) 
);
CREATE TABLE song (
	song_id serial,
	artist_name varchar(64),
	song_name varchar(64),
	featured_artist varchar(64),
	
	CONSTRAINT PK_song PRIMARY KEY (song_id),
	CONSTRAINT FK_song_artist_name FOREIGN KEY (artist_name) REFERENCES artist(artist_name)
);
CREATE TABLE event_host (
	user_id int NOT NULL,
	event_id int NOT NULL,
	
	CONSTRAINT PK_event_host PRIMARY KEY (user_id, event_id),
	CONSTRAINT FK_event_host_user_id FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT FK_event_host_event_id FOREIGN KEY (event_id) REFERENCES event(event_id) 
);
CREATE TABLE event_genre(
	genre_name varchar(64),
	event_id int NOT NULL,
	
	CONSTRAINT PK_event_genre PRIMARY KEY (genre_name, event_id),
	CONSTRAINT FK_event_genre_genre_name FOREIGN KEY (genre_name) REFERENCES genre(genre_name),
	CONSTRAINT FK_event_genre_event_id FOREIGN KEY (event_id) REFERENCES event(event_id)
);
CREATE TABLE song_genre(
	genre_name varchar(64),
	song_id int NOT NULL,
	
	CONSTRAINT PK_song_genre PRIMARY KEY (genre_name, song_id),
	CONSTRAINT FK_song_genre_genre_name FOREIGN KEY (genre_name) REFERENCES genre(genre_name),
	CONSTRAINT FK_song_genre_song_id FOREIGN KEY (song_id) REFERENCES song(song_id)
);
CREATE TABLE dj_library(
	user_id int NOT NULL,
	song_id int NOT NULL,
	
	CONSTRAINT PK_dj_library PRIMARY KEY (user_id, song_id),
	CONSTRAINT FK_dj_library_user_id FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT FK_dj_library_song_id FOREIGN KEY (song_id) REFERENCES song(song_id)
);
CREATE TABLE event_song(
	event_id int NOT NULL,
	song_id int NOT NULL,
	song_order int, 
	
	CONSTRAINT PK_event_song PRIMARY KEY (event_id, song_id),
	CONSTRAINT FK_event_song_event_id FOREIGN KEY (event_id) REFERENCES event(event_id),
	CONSTRAINT FK_event_song_song_id FOREIGN KEY (song_id) REFERENCES song(song_id)
);


--end of our tables

--- USER SETUP (Do Not Modify)
DROP USER IF EXISTS final_capstone_owner;
DROP USER IF EXISTS final_capstone_appuser;

CREATE USER final_capstone_owner
WITH PASSWORD 'finalcapstone';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO final_capstone_owner;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_owner;

CREATE USER final_capstone_appuser
WITH PASSWORD 'finalcapstone';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO final_capstone_appuser;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_appuser;


COMMIT TRANSACTION;





--start of mock data
--djs	
INSERT INTO users(username, password_hash, role)
VALUES ('DJDRae', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_DJ');

INSERT INTO users(username, password_hash, role)
VALUES ('DJGrid', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_DJ');

INSERT INTO users(username, password_hash, role)
VALUES ('LoopDaddy', '$2a$10$yF950I.DGZQFmFDISRH/N.8bYFUtHQ6EEF5F2j6xZzt7gYN7Zeex.', 'ROLE_DJ');

INSERT INTO users(username, password_hash, role)
VALUES ('DropTablesANDtheBass', '$2a$10$.abxEVP6wFAzuWWt.AbrLOXHcXWITpHE/cqu2SfomKe634MUzk5Ga', 'ROLE_DJ');

INSERT INTO users(username, password_hash, role)
VALUES ('IntelliJamz', '$2a$10$kZy7w217YKjt7fq3dYz3cOksedrCHVYQzU9vS2YN4R3Vlv89sHmkC', 'ROLE_DJ');

INSERT INTO users(username, password_hash, role)
VALUES ('DJFlexBox', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_DJ');




--hosts
INSERT INTO users(username, password_hash, role)
VALUES ('LilDebbie', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_HOST');

INSERT INTO users(username, password_hash, role)
VALUES ('JayGatsby', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_HOST');

INSERT INTO users(username, password_hash, role)
VALUES ('POJOdojo','$2a$10$MCkkNB9Vx.RxaABGJolB2eGpV/.pqitsj/SQqQgdqW9OpiIA32vWK', 'ROLE_HOST');

INSERT INTO users(username, password_hash, role)
VALUES ('DOMDeLuise','$2a$10$aG8BhPop20EJ8D01Anv8DezPcG305OouGcMWL/2YAob0576BWM2Ue', 'ROLE_HOST');

INSERT INTO users(username, password_hash, role)
VALUES ('BubbaHTTP', '$2a$10$UW8TMBSUCL/7WpTNFVk4Huf7MPzX11mZGTI3JNpv0iXjbWpQKNoO2', 'ROLE_HOST');




INSERT INTO event(user_id, event_name, information)
VALUES ('3', 'Foam Party', 'Bubbles and tunes'), ('3', 'Lollipopalooza', 'Caaaandy'), ('3', 'Cowabunga', 'Enjoy the mooooosic');

INSERT INTO genre(genre_name)
VALUES ('party'), ('pop'), ('rap'), ('country'), ('alternative'), ('rock'), ('metal'),('R&B'),('love'),('classic'),('moody');

INSERT INTO artist
VALUES ('P!nk'), ('LMFAO'), ('Outkast'), ('Usher'),('Salt-N-Pepa'), ('DJ Casper'), ('Lady Gaga'), ('Village People'), ('Flo Rida'), 
('Neil Diamond'), ('Cyndi Lauper'), ('Tag Team'), ('Prince'), ('Lizzo'), ('Smash Mouth'), ('Gorillaz'), ('Missy Elliott'),
('Sir Mix-a-Lot' ), ('Spice Girls'), ('Eminem'), ('Doja Cat'), ('Dr. Dre'), ('Kodak Black'),('Jay-Z'),('DaBaby'),('Justin Timberlake'),('Jack Harlow'),('Swae Lee'),('Taylor Swift'),('Jason Aldean'),('Luke Bryan'),
('Florida Georgia Line'),('Lee Brice'), ('Cardi B'),('A$AP Rocky'),('Snoop Dogg'),('Green Day'),('Oasis'),('Elvis Presley'),('Phil Collins'),('V.I.C.'),('Playboi Carti'),('Beyonce'),('The Chainsmokers'),('Avicii'),
('Pitbull'),('Kesha'), ('Lil Jon'),('Alesso'),('David Guetta'),('Skrillex'),('blink-182'),('PSY'),('3 Doors Down'),('Puddle Of Mudd'),('Nicki Minaj'),('Swedish House Mafia'),('Metallica'),('Aerosmith'),('Sheck Wes'),
('French Montana'),('AC/DC'),('Blake Shelton'),('Drake'),('Halsey'),('The Proclaimers'),('Lynyrd Skynyrd'),('Vitamin C'),('Post Malone'),('benny blanco'),('Juice WRLD'),('fun.'),('Black Eyed Peas'),
('Train'),('GAYLE'),('Macklemore'),('Kanye West'),('Nelly'),('Offset'),('My Chemical Romance'),('Paramore'),('Sublime'),('Ed Sheeran'),('John Legend'),('Robin Thicke'),('Pharrell Williams'),('Coldplay'),
('ABBA'),('Aqua'),('Third Eye Blind'),('Chumbawamba'),('Katy Perry'),('Juicy J'),('Guns N'' Roses'),('Twisted Sister'),('Journey'),('Foreigner'),('Duran Duran'),('The Beetles'),('Billy Joel'),
('John Mellencamp'),('Eagles'),('Sia'),('Lorde'),('Rihanna'),('Miley Cyrus'),('Desiigner'),('Five Finger Death Punch'),('Pantera'),('Hawthorne Heights'),('Poison'),('Bon Jovi'),('Ozzy Osbourne'),
('The Weather Girls'),('TLC'),('MC Hammer'),('Backstreet Boys'),('No Doubt');



INSERT INTO song (artist_name,song_name,featured_artist)
VALUES
('P!nk','Get The Party Started',null),
( 'LMFAO','Party Rock Anthem',null),
('Outkast','Hey Ya!',null),
('Usher','Yeah!',null),
('Salt-N-Pepa','Push It!',null),
('DJ Casper','Cha Cha Slide',null),
('Lady Gaga','Just Dance',null),
('Village People','Y.M.C.A.',null),
( 'Flo Rida', 'Low',null),
( 'Neil Diamond', 'Sweet Caroline',null),
( 'Cyndi Lauper', 'Girls Just Want To Have Fun',null),
( 'Tag Team', 'Whoomp, There It Is',null),
('Prince',  '1999',null),
('Lizzo','Truth Hurts',null),
( 'Smash Mouth', 'All Star',null),
( 'Gorillaz', 'DARE',null),
( 'Missy Elliott', 'Work It',null),
( 'Sir Mix-a-Lot', 'Baby Got Back',null),
('Spice Girls',  'Wannabe',null),
( 'Eminem', 'Lose Yourself',null),
( 'Doja Cat', 'Moo',null),
('Kodak Black','ZEZE','Offset'),
('Jay-Z','Holy Grail','Justin Timberlake'),
('AC/DC','Thunderstruck',null),
('DaBaby','PRACTICE',null),
('Swae Lee','Ball Is Life','Jack Harlow'),
('Taylor Swift','We Are Never Ever Getting Back Together',null),
('3 Doors Down','Kryptonite',null),
('PSY','Gangnam',null),
('Avicii','Levels','Skrillex'),
('Blake Shelton','Came Here To Forget',null),
('blink-182','All The Small Things',null),
('Florida Georgia Line','This Is How We Roll','Luke Bryan'),
('V.I.C.','Wobble',null),
('Puddle Of Mudd','She Hates Me',null),
('Nelly','Ride Wit Me',null),
('A$AP Rocky','Babushka Boi',null),
('Green Day','When I Come Around',null),
('Oasis','Wonderwall',null),
('Sublime','Santeria',null),
('Lynyrd Skynyrd','Free Bird',null),
('Halsey','Bad At Love',null),
('The Proclaimers','I''m Gonna Be (500 Miles)',null),
('Playboi Carti','Magnolia',null),
('My Chemical Romance','Welcome To The Black Parade',null),
('Paramore','Misery Business',null),
('Swedish House Mafia','One',null),
('Phil Collins','In The Air Tonight',null),
('Aerosmith','I Don''t Want To Miss A Thing',null),
('Juice WRLD','Lucid Dreams',null),
('The Chainsmokers','Closer','Halsey'),
('Halsey','Let Me Go','Florida Georgia Line'),
('Cardi B','Money',null),
('Kanye West','Mercy',null),
('GAYLE','abcdefu',null),
('Elvis Presley','Devil In Disguise',null),
('Post Malone','Congratulations',null),
('Green Day','Good Riddance (Time Of Our Lives)',null),
('Train','Marry Me',null),
('Prince','Purple Rain',null),
('Lil Jon','Low',null),
('Black Eyed Peas','I Gotta Feeling',null),
('Metallica','Enter Sandman',null),
('Pitbull','Timber','Kesha'),
('Kesha','Blow',null),
('Taylor Swift','Love Story',null),
('Jason Aldean','Burnin'' It Down',null),
('Luke Bryan','I Don''t Want This Night To End',null),
('Lee Brice','Love Like Crazy',null),
('Ed Sheeran','Thinking Out Loud',null),
('John Legend','All Of Me',null),
('Robin Thicke','Blurred Lines','Pharrell Williams'),
('Pharrell Williams','Happy',null),
('The Chainsmokers','Something Just Like This','Coldplay'),
('Vitamin C','Graduation (Friends Forever)',null),
('ABBA','Dancing Queen',null),
('Aqua','Barbie  Girl',null),
('Macklemore','Thift Shop',null),
('Drake','In My Feelings',null),
('Cardi B','I Like It',null),
('benny blanco','Eastside','Halsey'),
('French Montana','Unforgettable','Swae Lee'),
('Dr. Dre','I Need A Doctor','Eminem'),
('Oasis','Champagne Supernova',null),
('Third Eye Blind','Semi-Charmed Life',null),
('Chumbawamba','Tubthumping',null),
('Sheck Wes','Mo Bamba',null),
('Drake','Take Care','Rihanna'),
('Justin Timberlake','Suit  & Tie','Jay-Z'),
('Justin Timberlake','CAN''T STOP THE FEELING!',null),
('Katy Perry','Wide Awake',null),
('Katy Perry','Dark Horse','Juicy J'),
('Taylor Swift','...Ready For It?',null),
('Beyonce','Flawless Remix','Nicki Minaj'),
('Twisted Sister','We''re Not Gonna Take It',null),
('Guns N'' Roses','Sweet Child O'' Mine',null),
('Journey','Don''t Stop Believing',null),
('Foreigner','Hot Blooded',null),
('Eminem','Detroit Vs. Everybody',null),
('Duran Duran','Hungry Like The Wolf',null),
('Journey','Faithfully',null),
('Lynyrd Skynyrd','Sweet Home Alabama',null),
('The Beetles','I Want To Hold Your Hand',null),
('Billy Joel','Piano Man',null),
('3 Doors Down','Here Without You',null),
('Aerosmith','Crazy',null),
('John Mellencamp','Jack And Diane',null),
('Train','Soul  Sister',null),
('Eagles','Hotel California',null),
('Kodak Black','Calling My Spirit',null),
('Flo Rida','Club Can''t Handle Me','David Guetta'),
('Sia','Cheap Thrills',null),
('David Guetta','Titanium','Sia'),
('Lorde','Team',null),
('A$AP Rocky','Excuse Me',null),
('Jason Aldean','Tattoos On This Town',null),
('blink-182','What''s My Age Again?',null),
('Beyonce','Run The World (Girls)',null),
( 'Dr. Dre','Forgot About Dre','Eminem'),
('Rihanna','Monster','Eminem'),
('Desiigner','Panda',null),
('Miley Cyrus','Party In The USA',null),
('Five Finger Death Punch','Jekyll And Hyde',null),
('Pantera','Cemetery Gates',null),
('Hawthorne Heights','Diamond Eyes',null),
('Bon Jovi','It''s My Life',null),
('Poison','Every Rose Has Its Thorn',null),
('Bon Jovi','Bed Of Roses',null),
('Ozzy Osbourne','Crazy Train',null),
('Metallica','One',null),
('The Weather Girls','It''s Raining Men',null),
('TLC','No Scrubs',null),
('MC Hammer','Can''t Touch This',null),
('Backstreet Boys','I Want It That Way',null),
('Backstreet Boys', 'Everybody (Backstreet''s Back)',null),
('No Doubt','Just A Girl',null),
('TLC','Waterfalls',null);

INSERT INTO song_genre  (genre_name, song_id)
VALUES 
('party',1),
('party',2),
('party',3),
('party',4),
('party',5),
('party',6),
('party',7),
('party',8),
('party',9),
('classic',10),
('party',11),
('party',12),
('classic',13),
('classic',14),
('party',15),
('party',16),
('party',17),
('party',18),
('party',19),
('rap',20),
('pop',21),
('rap',22),
('rap',23),
('rock',24),
('rap',25),
('rap',26),
('pop',27),
('alternative',28),
('party',29),
('party',30),
('country',31),
('alternative',32),
('country',33),
('party',34),
('alternative',35),
('R&B',36),
('rap',37),
('alternative',38),
('alternative',39),
('alternative',40),
('classic',41),
('pop',42),
('classic',43),
('rap',44),
('alternative',45),
('alternative',46),
('party',47),
('classic',48),
('love',49),
('rap',50),
('party',51),
('pop',52),
('rap',53),
('rap',54),
('pop',55),
('classic',56),
('R&B',57),
('alternative',58),
('love',59),
('classic',60),
('party',61),
('party',62),
('metal',63),
('party',64),
('party',65),
('love',66),
('country',67),
('country',68),
('country',69),
('love',70),
('love',71),
('pop',72),
('pop',73),
('pop',74),
('party',75),
('party',76),
('party',77),
('party',78),
('R&B',79),
('party',80),
('pop',81),
('R&B',82),
('rap',83),
('alternative',84),
('alternative',85),
('alternative',86),
('rap',87),
('R&B',88),
('pop',89),
('pop',90),
('pop',91),
('pop',92),
('pop',93),
('rap',94),
('rock',95),
('rock',96),
('rock',97),
('rock',98),
('rap',99),
('rock',100),
('love',101),
('classic',102),
('classic',103),
('classic',104),
('rock',105),
('love',106),
('classic',107),
('pop',108),
('classic',109),
('rap',110),
('party',111),
('party',112),
('party',113),
('pop',114),
('rap',115),
('country',116),
('alternative',117),
('pop',118),
('rap',119),
('rap',120),
('party',121),
('party',122),
('metal',123),
('metal',124),
('metal',125),
('classic',126),
('love',127),
('love',128),
('metal',129),
('metal',130),
('classic',131),
('R&B',132),
('party',133),
('pop',134),
('pop',135),
('pop',136),
('R&B',137);

INSERT INTO song_genre (genre_name, song_id)
VALUES
('classic',11),
('party',22),
('rap',34),
('rock',35),
('rock',41),
('rap',61),
('pop',66),
('love',69),
('party',72);

--event songs
INSERT INTO event_song(event_id, song_id)
VALUES (1, '6'),(1, '8'), (1,'10'),(1,'11'),(1,'12'),(1,'13'),(1,'15'),(1,'18'),(1,'19'),(1,'24'),(1,'29'),(1,'43'),(1,'48'),(1,'49'),(1,'62'),
(1,'73'),(1,'75'),(1,'76'),(1,'77'),(1,'86'),(1,'95'),(1,'96'),(1,'97'),(1,'98'),(1,'102'),(1,'103'),(1,'104'),
(1,'106'),(1,'107'),(1,'108'),(1,'109'),(1,'122'),(1,'126'),(1,'131'),(1,'132'),(1,'133'),(1, '134'),
(1,'135'),(1,'136'),(1,'137');

INSERT INTO event_song(event_id, song_id)
VALUES (2, '18'), (2, '20'), (2, '22'),(2,'21'),(2,'25'),(2,'26'),(2,'34'),(2,'36'),(2,'37'),(2,'42'),(2,'44'),(2,'53'),(2,'54'),(2,'55'),(2,'57'),
(2,'61'),(2,'64'),(2,'65'),(2,'78'),(2,'79'),(2,'80'),(2, '82'),(2,'81'),(2,'87'),(2,'119'),(2,'115'),(2,'120');

INSERT INTO event_song(event_id, song_id)
VALUES (3,'21'),(3,'29'),(3,'31'),(3,'33'),(3,'35'),(3,'41'),(3,'47'),(3,'55'),(3,'56'),(3,'63'),(3,'70'),(3,'105'),(3,'116'),
(3,'123'),(3,'124'),(3,'126'),(3,'127'),(3,'128'),(3,'129'),(3,'130');


--DJ libraries
INSERT INTO dj_library(user_id, song_id)
VALUES ('3', '1'), ('3', '2'), ('3', '3'), ('3', '4'),('3','5'), ('3','9'),('3','14'),('3','16'),('3','18'),('3','20'),('3','23'),('3','24'),('3','25'),
('3','26'),('3','28'),('3','30'),('3','31'),('3','33'),('3','34'),('3','35'),('3','36'),('3','39'),('3','42'),
('3','44'),('3','47'),('3','49'),('3','52'),('3','53'),('3','54'),('3','57'),('3','61'),('3','63'),('3','65'),
('3', '71'),('3','73'),('3','76'),('3','78'),('3','80'),('3','82'),('3','87'),('3','89'),('3','95'),('3','99'),
('3','108'),('3','110'),('3','111'),('3','114'),('3','125'),('3','127'),('3','129'),('3','131'),('3','134'),
('3','137');

INSERT INTO dj_library(user_id, song_id)
VALUES ('4','1'),('4','3'),('4','5'),('4','7'),('4','9'),('4','11'),('4','13'),('4','15'),('4','17'),('4','19'),('4','21'),
('4','33'),('4','34'),('4','35'),('4','36'),('4','41'),('4','43'),('4','45'),('4','47'),('4','49'),('4','50'),('4','51'),
('4','52'),('4','61'),('4','63'),('4','65'),('4','67'),('4','69'),('4','77'),('4','78'),('4','79'),('4','80'),
('4', '81'),('4','83'),('4','85'),('4','87'),('4','89'),('4','92'),('4','94'),('4','96'),('4','101'),('4','103'),
('4','105'),('4','107'),('4','109'),('4','115'),('4','119'),('4','121'),('4','123'),('4','125'),('4','127'),('4','129'),
('4', '136'),('4','137');

INSERT INTO dj_library(user_id, song_id)
VALUES ('7','3'),('7','17'),('7','32'),('7','44'),('7','54'),('7','56'),('7','68'),('7','79'),('7','94'),('7','99');

INSERT INTO dj_library(user_id, song_id)
VALUES ('10','124'),('10','125'),('10','126'),('10','127'),('10','128'),('10','129'),('10','130'),('10','131');

INSERT INTO dj_library(user_id, song_id)
VALUES ('12','94'),('12','95'),('12','96'),('12','97'),('12','98'),('12','99'),('12','100'),('12','13'),('12','14'),('12','15'),
('12','37');

INSERT INTO event_genre(genre_name, event_id)
VALUES ('party', 1), ('rap', 2), ('pop', 3);

--event hosts
INSERT INTO event_host (user_id,event_id)
VALUES (9,1), (6,1);

INSERT INTO event_host (user_id,event_id)
VALUES (11,2);

INSERT INTO event_host (user_id,event_id)
VALUES (9,3), (11,3);



--end of mock data
