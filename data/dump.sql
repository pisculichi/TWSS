PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE movie (
	id INTEGER NOT NULL, 
	title VARCHAR(100) NOT NULL, 
	director VARCHAR(100), 
	duration INTEGER, 
	synopsis TEXT, 
	year INTEGER, 
	calification VARCHAR(100), 
	distribuidory VARCHAR(100), 
	PRIMARY KEY (id)
);
INSERT INTO "movie" VALUES(1,'The Fate of the Furious','F. Gary Gray',136,'When a mysterious woman seduces Dom into the world of terrorism and a betrayal of those closest to him, the crew face trials that will test them as never before.',2017,'PG-13',NULL);
INSERT INTO "movie" VALUES(2,'Colossal','Nacho Vigalondo',110,'A woman discovers that severe catastrophic events are somehow connected to the mental breakdown from which she''s suffering.',2017,'R',NULL);
INSERT INTO "movie" VALUES(3,'Gifted',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "movie" VALUES(4,'Ghost in the Shell','Mamoru Oshii',83,'A cyborg policewoman and her partner hunt a mysterious and powerful hacker called the Puppet Master.',1996,'NOT RATED',NULL);
INSERT INTO "movie" VALUES(5,'The Boss Baby','Tom McGrath',97,'A suit-wearing briefcase-carrying baby pairs up with his seven-year old brother to stop the dastardly plot of the CEO of Puppy Co.',2017,'PG',NULL);
INSERT INTO "movie" VALUES(6,'T2: Trainspotting','Danny Boyle',117,'After 20 years abroad, Mark Renton returns to Scotland and reunites with his old friends Sick Boy, Spud, and Begbie.',2017,'R',NULL);
INSERT INTO "movie" VALUES(7,'Kong: Skull Island','Jordan Vogt-Roberts',118,'A team of scientists explore an uncharted island in the Pacific, venturing into the domain of the mighty Kong, and must fight to escape a primal Eden.',2017,'PG-13',NULL);
INSERT INTO "movie" VALUES(8,'Logan','James Mangold',141,'In the near future, a weary Logan cares for an ailing Professor X somewhere on the Mexican border. However, Logan''s attempts to hide from the world and his legacy are upended when a young mutant arrives, pursued by dark forces.',2017,'R',NULL);
INSERT INTO "movie" VALUES(9,'Get Out','Jordan Peele',104,'A young African-American man visits his Caucasian girlfriend''s mysterious family estate.',2017,'R',NULL);
CREATE TABLE cinema (
	id INTEGER NOT NULL, 
	name VARCHAR(150) NOT NULL, 
	PRIMARY KEY (id)
);
INSERT INTO "cinema" VALUES(1,'Regal Union Square Stadium 14');
CREATE TABLE genre (
	id INTEGER NOT NULL, 
	name VARCHAR(150) NOT NULL, 
	PRIMARY KEY (id)
);
INSERT INTO "genre" VALUES(1,'Action');
INSERT INTO "genre" VALUES(2,'Crime');
INSERT INTO "genre" VALUES(3,'Thriller');
INSERT INTO "genre" VALUES(4,'Comedy');
INSERT INTO "genre" VALUES(5,'Sci-Fi');
INSERT INTO "genre" VALUES(6,'Animation');
INSERT INTO "genre" VALUES(7,'Family');
INSERT INTO "genre" VALUES(8,'Drama');
INSERT INTO "genre" VALUES(9,'Adventure');
INSERT INTO "genre" VALUES(10,'Fantasy');
INSERT INTO "genre" VALUES(11,'Horror');
INSERT INTO "genre" VALUES(12,'Mystery');
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
INSERT INTO "showtime" VALUES(1,NULL,'2017-04-15 19:30:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(2,NULL,'2017-04-15 20:20:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(3,NULL,'2017-04-15 21:00:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(4,NULL,'2017-04-15 21:50:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(5,NULL,'2017-04-15 22:10:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(6,NULL,'2017-04-15 22:50:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(7,NULL,'2017-04-15 23:30:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(8,NULL,'2017-04-16 00:10:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(9,NULL,'2017-04-16 01:00:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(10,NULL,'2017-04-16 01:40:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(11,NULL,'2017-04-16 02:00:00.000000','2D',1,1);
INSERT INTO "showtime" VALUES(12,NULL,'2017-04-15 21:10:00.000000','2D',1,5);
INSERT INTO "showtime" VALUES(13,NULL,'2017-04-15 23:40:00.000000','2D',1,5);
INSERT INTO "showtime" VALUES(14,NULL,'2017-04-15 21:30:00.000000','2D',1,3);
INSERT INTO "showtime" VALUES(15,NULL,'2017-04-16 00:20:00.000000','2D',1,3);
INSERT INTO "showtime" VALUES(16,NULL,'2017-04-15 20:50:00.000000','2D',1,7);
INSERT INTO "showtime" VALUES(17,NULL,'2017-04-15 23:50:00.000000','2D',1,7);
INSERT INTO "showtime" VALUES(18,NULL,'2017-04-15 21:40:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(19,NULL,'2017-04-16 00:30:00.000000','2D',1,6);
INSERT INTO "showtime" VALUES(20,NULL,'2017-04-15 19:40:00.000000','2D',1,4);
INSERT INTO "showtime" VALUES(21,NULL,'2017-04-15 19:50:00.000000','2D',1,2);
INSERT INTO "showtime" VALUES(22,NULL,'2017-04-15 22:45:00.000000','2D',1,2);
INSERT INTO "showtime" VALUES(23,NULL,'2017-04-15 19:10:00.000000','2D',1,9);
INSERT INTO "showtime" VALUES(24,NULL,'2017-04-15 20:30:00.000000','2D',1,9);
INSERT INTO "showtime" VALUES(25,NULL,'2017-04-15 22:00:00.000000','2D',1,9);
INSERT INTO "showtime" VALUES(26,NULL,'2017-04-15 23:10:00.000000','2D',1,9);
INSERT INTO "showtime" VALUES(27,NULL,'2017-04-16 00:35:00.000000','2D',1,9);
INSERT INTO "showtime" VALUES(28,NULL,'2017-04-15 19:20:00.000000','2D',1,8);
INSERT INTO "showtime" VALUES(29,NULL,'2017-04-15 22:40:00.000000','2D',1,8);
INSERT INTO "showtime" VALUES(30,NULL,'2017-04-15 22:30:00.000000','3D',1,4);
CREATE TABLE movie_genre (
	movie_id INTEGER, 
	genre_id INTEGER, 
	FOREIGN KEY(movie_id) REFERENCES movie (id), 
	FOREIGN KEY(genre_id) REFERENCES genre (id)
);
INSERT INTO "movie_genre" VALUES(1,1);
INSERT INTO "movie_genre" VALUES(1,2);
INSERT INTO "movie_genre" VALUES(1,3);
INSERT INTO "movie_genre" VALUES(2,1);
INSERT INTO "movie_genre" VALUES(2,4);
INSERT INTO "movie_genre" VALUES(2,5);
INSERT INTO "movie_genre" VALUES(4,6);
INSERT INTO "movie_genre" VALUES(4,1);
INSERT INTO "movie_genre" VALUES(4,2);
INSERT INTO "movie_genre" VALUES(5,6);
INSERT INTO "movie_genre" VALUES(5,4);
INSERT INTO "movie_genre" VALUES(5,7);
INSERT INTO "movie_genre" VALUES(6,8);
INSERT INTO "movie_genre" VALUES(7,1);
INSERT INTO "movie_genre" VALUES(7,9);
INSERT INTO "movie_genre" VALUES(7,10);
INSERT INTO "movie_genre" VALUES(8,1);
INSERT INTO "movie_genre" VALUES(8,8);
INSERT INTO "movie_genre" VALUES(8,5);
INSERT INTO "movie_genre" VALUES(9,11);
INSERT INTO "movie_genre" VALUES(9,12);
COMMIT;
