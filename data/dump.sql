PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE genre (
	id INTEGER NOT NULL, 
	name VARCHAR(150) NOT NULL, 
	PRIMARY KEY (id)
);
INSERT INTO "genre" VALUES(1,'Comedy');
INSERT INTO "genre" VALUES(2,'Drama');
INSERT INTO "genre" VALUES(3,'Sci-Fi');
INSERT INTO "genre" VALUES(4,'Thriller');
INSERT INTO "genre" VALUES(5,'Action');
INSERT INTO "genre" VALUES(6,'Adventure');
INSERT INTO "genre" VALUES(7,'Crime');
INSERT INTO "genre" VALUES(8,'Animation');
INSERT INTO "genre" VALUES(9,'Family');
INSERT INTO "genre" VALUES(10,'Horror');
INSERT INTO "genre" VALUES(11,'Mystery');
CREATE TABLE cinema (
	id INTEGER NOT NULL, 
	name VARCHAR(150) NOT NULL, 
	url VARCHAR(300), 
	PRIMARY KEY (id)
);
INSERT INTO "cinema" VALUES(1,'Regal Union Square Stadium 14','http://www.fandango.com/regalunionsquarestadium14_aajnk/theaterpage');
CREATE TABLE movie (
	id INTEGER NOT NULL, 
	title VARCHAR(100) NOT NULL, 
	director VARCHAR(100), 
	duration INTEGER, 
	synopsis TEXT, 
	year INTEGER, 
	calification VARCHAR(100), 
	distribuidory VARCHAR(100), 
	url VARCHAR(300), 
	PRIMARY KEY (id)
);
INSERT INTO "movie" VALUES(1,'How to Be a Latin Lover','Ken Marino',115,'Finding himself dumped after 25 years of marriage, a man who made a career of seducing rich older women must move in with his estranged sister, where he begins to learn the value of family.',2017,'PG-13',NULL,'http://www.imdb.com/title/tt4795124');
INSERT INTO "movie" VALUES(2,'The Circle','James Ponsoldt',110,'A woman lands a dream job at a powerful tech company called the Circle, only to uncover a nefarious agenda that will affect the lives of her friends, family and that of humanity.',2017,'PG-13',NULL,'http://www.imdb.com/title/tt4287320');
INSERT INTO "movie" VALUES(3,'Baahubali 2','S.S. Rajamouli',167,'When Shiva, the son of Bahubali, learns about his heritage, he begins to look for answers. His story is juxtaposed with past events that unfolded in the Mahishmati Kingdom.',2017,'13',NULL,'http://www.imdb.com/title/tt4849438');
INSERT INTO "movie" VALUES(4,'Free Fire','Ben Wheatley',90,'Set in Boston in 1978, a meeting in a deserted warehouse between two gangs turns into a shootout and a game of survival.',2017,'R',NULL,'http://www.imdb.com/title/tt4158096');
INSERT INTO "movie" VALUES(5,'Unforgettable',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "movie" VALUES(6,'The Fate of the Furious','F. Gary Gray',136,'When a mysterious woman seduces Dom into the world of terrorism and a betrayal of those closest to him, the crew face trials that will test them as never before.',2017,'PG-13',NULL,'http://www.imdb.com/title/tt4630562');
INSERT INTO "movie" VALUES(7,'Colossal','Nacho Vigalondo',109,'Gloria is an out-of-work party girl forced to leave her life in NY and move back home. When reports surface that a giant creature is destroying Seoul, she gradually comes to the realization that she is somehow connected to this phenomenon.',2017,'R',NULL,'http://www.imdb.com/title/tt4680182');
INSERT INTO "movie" VALUES(8,'Ghost in the Shell','Rupert Sanders',107,'In the near future, Major is the first of her kind: A human saved from a terrible crash, who is cyber-enhanced to be a perfect soldier devoted to stopping the world''s most dangerous criminals.',2017,'PG-13',NULL,'http://www.imdb.com/title/tt1219827');
INSERT INTO "movie" VALUES(9,'The Boss Baby','Tom McGrath',97,'A suit-wearing briefcase-carrying baby pairs up with his seven-year old brother to stop the dastardly plot of the CEO of Puppy Co.',2017,'PG',NULL,'http://www.imdb.com/title/tt3874544');
INSERT INTO "movie" VALUES(10,'Logan','James Mangold',137,'In the near future, a weary Logan cares for an ailing Professor X somewhere on the Mexican border. However, Logan''s attempts to hide from the world and his legacy are upended when a young mutant arrives, pursued by dark forces.',2017,'R',NULL,'http://www.imdb.com/title/tt3315342');
INSERT INTO "movie" VALUES(11,'Get Out','Jordan Peele',104,'A young African-American man visits his Caucasian girlfriend''s mysterious family estate.',2017,'R',NULL,'http://www.imdb.com/title/tt5052448');
CREATE TABLE movie_genre (
	movie_id INTEGER, 
	genre_id INTEGER, 
	FOREIGN KEY(movie_id) REFERENCES movie (id), 
	FOREIGN KEY(genre_id) REFERENCES genre (id)
);
INSERT INTO "movie_genre" VALUES(1,1);
INSERT INTO "movie_genre" VALUES(2,2);
INSERT INTO "movie_genre" VALUES(2,3);
INSERT INTO "movie_genre" VALUES(2,4);
INSERT INTO "movie_genre" VALUES(3,5);
INSERT INTO "movie_genre" VALUES(3,6);
INSERT INTO "movie_genre" VALUES(3,2);
INSERT INTO "movie_genre" VALUES(4,5);
INSERT INTO "movie_genre" VALUES(4,7);
INSERT INTO "movie_genre" VALUES(4,4);
INSERT INTO "movie_genre" VALUES(6,5);
INSERT INTO "movie_genre" VALUES(6,6);
INSERT INTO "movie_genre" VALUES(6,7);
INSERT INTO "movie_genre" VALUES(7,5);
INSERT INTO "movie_genre" VALUES(7,1);
INSERT INTO "movie_genre" VALUES(7,3);
INSERT INTO "movie_genre" VALUES(8,5);
INSERT INTO "movie_genre" VALUES(8,7);
INSERT INTO "movie_genre" VALUES(8,2);
INSERT INTO "movie_genre" VALUES(9,8);
INSERT INTO "movie_genre" VALUES(9,1);
INSERT INTO "movie_genre" VALUES(9,9);
INSERT INTO "movie_genre" VALUES(10,5);
INSERT INTO "movie_genre" VALUES(10,2);
INSERT INTO "movie_genre" VALUES(10,3);
INSERT INTO "movie_genre" VALUES(11,10);
INSERT INTO "movie_genre" VALUES(11,11);
CREATE TABLE showtime (
	id INTEGER NOT NULL, 
	language VARCHAR(60), 
	date DATETIME NOT NULL, 
	room VARCHAR(45) NOT NULL, 
	cinema_id INTEGER, 
	movie_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(cinema_id) REFERENCES cinema (id), 
	FOREIGN KEY(movie_id) REFERENCES movie (id)
);
INSERT INTO "showtime" VALUES(1,NULL,'2017-04-30 16:40:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(2,NULL,'2017-04-30 17:30:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(3,NULL,'2017-04-30 18:20:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(4,NULL,'2017-04-30 19:10:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(5,NULL,'2017-04-30 20:00:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(6,NULL,'2017-04-30 20:50:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(7,NULL,'2017-04-30 21:40:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(8,NULL,'2017-04-30 22:30:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(9,NULL,'2017-04-30 23:10:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(10,NULL,'2017-04-30 16:20:00.000000','2D',1,9);
INSERT INTO "showtime" VALUES(11,NULL,'2017-04-30 18:50:00.000000','2D',1,9);
INSERT INTO "showtime" VALUES(12,NULL,'2017-04-30 21:30:00.000000','2D',1,9);
INSERT INTO "showtime" VALUES(13,NULL,'2017-04-30 18:10:00.000000','2D',1,8);
INSERT INTO "showtime" VALUES(14,NULL,'2017-04-30 21:00:00.000000','2D',1,8);
INSERT INTO "showtime" VALUES(15,NULL,'2017-04-30 21:20:00.000000','2D',1,4);
INSERT INTO "showtime" VALUES(16,NULL,'2017-04-30 17:10:00.000000','2D',1,7);
INSERT INTO "showtime" VALUES(17,NULL,'2017-04-30 20:20:00.000000','2D',1,7);
INSERT INTO "showtime" VALUES(18,NULL,'2017-04-30 23:15:00.000000','2D',1,7);
INSERT INTO "showtime" VALUES(19,NULL,'2017-04-30 16:10:00.000000','2D',1,11);
INSERT INTO "showtime" VALUES(20,NULL,'2017-04-30 19:00:00.000000','2D',1,11);
INSERT INTO "showtime" VALUES(21,NULL,'2017-04-30 21:50:00.000000','2D',1,11);
INSERT INTO "showtime" VALUES(22,NULL,'2017-04-30 18:40:00.000000','2D',1,10);
INSERT INTO "showtime" VALUES(23,NULL,'2017-04-30 22:00:00.000000','2D',1,10);
INSERT INTO "showtime" VALUES(24,NULL,'2017-04-30 17:00:00.000000','2D',1,2);
INSERT INTO "showtime" VALUES(25,NULL,'2017-04-30 19:50:00.000000','2D',1,2);
INSERT INTO "showtime" VALUES(26,NULL,'2017-04-30 22:50:00.000000','2D',1,2);
INSERT INTO "showtime" VALUES(27,NULL,'2017-04-30 16:30:00.000000','2D',1,5);
INSERT INTO "showtime" VALUES(28,NULL,'2017-04-30 19:30:00.000000','2D',1,5);
INSERT INTO "showtime" VALUES(29,NULL,'2017-04-30 22:10:00.000000','2D',1,5);
INSERT INTO "showtime" VALUES(30,NULL,'2017-04-30 16:50:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(31,NULL,'2017-04-30 18:30:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(32,NULL,'2017-04-30 19:40:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(33,NULL,'2017-04-30 22:40:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(34,NULL,'2017-04-30 19:20:00.000000','2D',1,3);
INSERT INTO "showtime" VALUES(35,NULL,'2017-04-30 23:00:00.000000','2D',1,3);
COMMIT;
