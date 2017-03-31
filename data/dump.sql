PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE genre (
	id INTEGER NOT NULL, 
	name VARCHAR(150) NOT NULL, 
	PRIMARY KEY (id)
);
INSERT INTO "genre" VALUES(1,'Drama');
INSERT INTO "genre" VALUES(2,'Ciencia Ficción');
INSERT INTO "genre" VALUES(3,'Drama - Biográfico');
INSERT INTO "genre" VALUES(4,'Thriller');
INSERT INTO "genre" VALUES(5,'Drama romantico');
INSERT INTO "genre" VALUES(6,'Comedia');
INSERT INTO "genre" VALUES(7,'Acción');
INSERT INTO "genre" VALUES(8,'Aventuras');
INSERT INTO "genre" VALUES(9,'Suspenso');
INSERT INTO "genre" VALUES(10,'Fantasía');
INSERT INTO "genre" VALUES(11,'Terror');
INSERT INTO "genre" VALUES(12,'Comedia dramática');
INSERT INTO "genre" VALUES(13,'Animación');
CREATE TABLE movie (
	id INTEGER NOT NULL, 
	title VARCHAR(100) NOT NULL, 
	director VARCHAR(100), 
	duration VARCHAR(20), 
	synopsis TEXT, 
	calification VARCHAR(100), 
	distribuidory VARCHAR(100), 
	PRIMARY KEY (id)
);
INSERT INTO "movie" VALUES(1,'EL OTRO HERMANO','Adrián Caetano','112 minutos.','Cetarti está hundido en la nada. Sin trabajo ni propósito, pasa sus días encerrado viendo la televisión y fumando porros hasta que un desconocido le informa de que su madre y su hermano han sido asesinados a escopetazos. Viaja a Lapachito, el derruido pueblo donde vivía su madre, para hacerse cargo de los cadáveres. Allí, conoce a Duarte, antiguo militar, albacea y amigo del asesino de su madre, y a Danielito. El derrotero de Cetarti incluirá las chapuzas ilegales para cobrar un seguro y la nebulosa complicidad en los oscuros negocios de Duarte.','No determinado',NULL);
INSERT INTO "movie" VALUES(2,'GHOST IN THE SHELL: VIGILANTE DEL FUTURO','Rupert Sanders','120 minutos.','Basada en la internacionalmente aclamada saga de ciencia ficción, "GHOST IN THE SHELL" narra la historia de the Major, un híbrido cyborg-humano femenino único en su especie, de operaciones especiales, que dirige un grupo operativo de elite llamado Sección 9. Consagrada a detener a los extremistas y criminales más peligrosos, la Sección 9 se enfrenta a un enemigo cuyo objetivo principal consiste en anular los avances de Hanka Robotic en el campo de la ciber-tecnología.','No determinado',NULL);
INSERT INTO "movie" VALUES(3,'HAMBRE DE PODER','John Lee Hancock','115 minutos.','Biografía del creador de McDonald''s. En los años 50, un vendedor de Illinois llamado Ray Kroc conoció a los hermanos Richard y Maurice McDonald que llevaban una hamburguesería al sur de California. Impresionado por la velocidad del sistema de cocina de su hamburguesería de San Bernardino, Kroc visualizó el potencial de la franquicia y hábilmente se fue posicionando para arrebatárselo a los hermanos y crear el hoy imperio de mil millones de dólares. Así nació McDonald''s.','No determinado',NULL);
INSERT INTO "movie" VALUES(4,'HIPERSOMNIA','Gabriel Grieco','90 minutos.','Milena es una joven actriz que quiere obtener el papel de una obra de teatro a toda costa. Finalmente, queda elegida para protagonizar una obra comprometida. Ella está feliz pero su novio un poco celoso y un poco preocupado. Al principio todo es normal. Pero cuando Milena comienza a trabajar sobre la obra, algo raro comienza a sucederle. Sin notarlo en un primer momento, cada vez que lee una escena específica de la obra pareciera transportarse a una casa donde está prisionera junto con otras chicas. Allí parece tener un pasado, un presente y un futuro incierto. Como la obra que está ensayando aborda el tema de la prostitución, Milena lo atribuye al stress y al estar trabajando en la obra sobre esa temática. Pero las idas y vueltas se van repitiendo y la vida "del otro lado" parece ser muy real. Lo que en un primer momento se cree que es un trastorno del sueño lentamente se irá convirtiendo en una verdad oculta que Milena no tendrá otra opción que enfrentar.','No determinado',NULL);
INSERT INTO "movie" VALUES(5,'POLINA','Angelin Preljocaj','112 minutos.','A principios de la década del 90, Polina tiene ocho años y un gran potencial para la danza. Junto a un entrenador de bailarines del Teatro Bolshoi, una década más tarde ingresará en ese cuerpo y conocerá a un colega francés con el que su vida cambiará para siempre. La pasión y el amor por la danza, llevados al máximo de la expresión cinematográfica, a partir de una exitosa historia gráfica publicada en diez idiomas.','No determinado',NULL);
INSERT INTO "movie" VALUES(6,'POWER RANGERS','Dean Israelite','No disponible','La película sigue a cinco ordinarios jóvenes en la preparatoria que tienen que convertirse en algo extraordinario cuando descubren que su modesto poblado de Angel Grove -y el resto del mundo- está al borde de la aniquilación por una amenaza alienígena. Elegidos por el destino, nuestros héroes descubren rápidamente que son los únicos que pueden salvar al planeta. Pero para lograrlo tendrán que superar problemas de la vida real y unirse como los Power Rangers antes de que sea demasiado tarde.','No determinado',NULL);
INSERT INTO "movie" VALUES(7,'50 SOMBRAS MÁS OSCURAS','James Foley','117 minutos.','Secuela de "50 sombras de Grey", en la que Christian Grey sigue explorando sus demonios interiores y la joven Anastasia confronta sus sentimientos, confusión y rabia sobre su relación con el atractivo millonario, una tipo misterioso lleno de secretos.','Prohibida para menores de 16 años con reservas',NULL);
INSERT INTO "movie" VALUES(8,'CASI LEYENDAS','Gabriel Nesci','116 minutos.','Tres amigos distanciados se van a ver obligados a reunirse muy a su pesar. Axel (Santiago Segura), un español muy particular, decide emprender la búsqueda de sus ex compañeros en Buenos Aires. Hace 25 años formaron un grupo musical que estuvo a punto de ser famoso pero por misteriosas razones nunca lo logró.
Ahora Axel va a tener que reencontrarse con Javier (Diego Peretti), un profesor que no logra comunicarse con su hijo adolescente, y Lucas (Diego Torres), un abogado presumido que pierde su trabajo de un día para el otro. Los espera un doble desafío: ser la banda que siempre soñaron y como si fuese poco solucionar sus calamitosas vidas.','Apta mayores de 13 años',NULL);
INSERT INTO "movie" VALUES(9,'CHIPS: PATRULLA MOTORIZADA RECARGADA','Dax Shepard','100 minutos.','Jon Baker y Frank "Ponch" Poncherello se acaban de enlistar en las fuerzas de la Policía Estatal de Caminos de California, en Los Angeles. Cada uno por motivos muy distintos. Baker es un motociclista profesional destrozado, que está tratando de poner su vida en orden y recuperar su matrimonio. Poncherello es un agente federal encubierto que investiga un fraude multimillonario, que se sospecha puede ser un caso de corrupción dentro del mismo departamento de policía.','Apta mayores de 13 años',NULL);
INSERT INTO "movie" VALUES(10,'DOS NOCHES HASTA MAÑANA','Mikko Kuparinen','88 minutos.','Una aventura de una noche de dos extraños sin un lenguaje común en un país extranjero da un giro inesperado, cuando una nube de polvo de un volcán impide que todos los vuelos puedan despegar.','Apta mayores de 13 años',NULL);
INSERT INTO "movie" VALUES(11,'EL PESO DE LA LEY','Fernán Mirás','101 minutos.','Es la historia de Gloria, una joven abogada descreída de su profesión, ya que nunca pudo defender a alguien que no fuera culpable. Y su nuevo cliente no parece ser muy distinto: un hombre acusado de violación en un pequeño pueblo donde nadie cree su historia','Apta mayores de 13 años',NULL);
INSERT INTO "movie" VALUES(12,'ELLE: ABUSO Y SEDUCCIÓN','Paul Verhoeven','130 minutos.','Michèle, exitosa ejecutiva de una empresa de videojuegos, busca venganza tras ser asaltada de forma violenta en su propia casa por un intruso','Prohibida para menores de 16 años con reservas',NULL);
INSERT INTO "movie" VALUES(13,'FRAGMENTADO','M. Night Shyamalan','117 minutos.','A pesar de que Kevin (James McAvoy) le ha demostrado a su psiquiatra de confianza, la Dra. Fletcher (Betty Buckley), que posee 23 personalidades diferentes, aún queda una por emerger, decidida a dominar a todas las demás. Obligado a raptar a tres chicas adolescentes encabezadas por la decidida y observadora Casey (Anya Taylor-Joy), Kevin lucha por sobrevivir contra todas sus personalidades y la gente que le rodea, a medida que las paredes de sus compartimentos mentales se derrumban','Apta mayores de 16 años',NULL);
INSERT INTO "movie" VALUES(14,'KONG: LA ISLA CALAVERA','Jordan Vogt-Roberts','118 minutos.','Un diverso equipo de exploradores es reunido para aventurarse en el interior de una isla del Pacífico -tan bella como traicionera- que no aparece en los mapas, sin saber que están invadiendo los dominios del mítico King Kong','Prohibida para menores de 13 años con reservas',NULL);
INSERT INTO "movie" VALUES(15,'LA BELLA Y LA BESTIA.','Bill Condon','129 minutos.','Adaptación en imagen real del clásico de Disney "La bella y la bestia", que cuenta la historia de una joven que para salvar a su padre, decide ir a un castillo y quedar ahí atrapada junto a una bestia maldita','apta para todo público con reservas.',NULL);
INSERT INTO "movie" VALUES(16,'LA LLAMADA 3','F. Javier Gutiérrez','102 minutos.','Precuela de ''The Ring'', que contará la historia de cómo una joven descubre la cinta de vídeo de Samara y se convierte en su primera víctima','Prohibida para menores de 13 años con reservas',NULL);
INSERT INTO "movie" VALUES(17,'LA RAZON DE ESTAR CONTIGO','Lasse Hallström','100 minutos.','Comparte la conmovedora y sorprendente historia de un perro leal (voz de Josh Gad) que encuentra el significado de su propia existencia a través de la vida de los humanos a los que les enseña a reír y amar. Esta película familiar, es narrada desde la perspectiva del perro.','Apta todo público C/L',NULL);
INSERT INTO "movie" VALUES(18,'LEGO BATMAN: LA PELÍCULA','Chris McKay','104 minutos.','Bruce Wayne no sólo debe manejar enfrentamientos con los peores criminales de Ciudad Gotica, ahora también debe hacerse cargo de un joven al que ha adoptado.','Apta todo público',NULL);
INSERT INTO "movie" VALUES(19,'LIFE: VIDA INTELIGENTE','Daniel Espinosa','104 minutos.','Life narra la historia de los seis miembros de la tripulación de la Estación Espacial Internacional que están a punto de lograr uno de los descubrimientos más importantes en la historia humana: la primera evidencia de vida extraterrestre en Marte. A medida que el equipo comienza a investigar y sus métodos tienen consecuencias inesperadas, la forma viviente demostrará ser más inteligente de lo que cualquiera esperaba.','Apta mayores de 16 años',NULL);
INSERT INTO "movie" VALUES(20,'LOGAN','James Mangold','137 minutos.','Ha pasado un año tras los eventos de "X-Men: Days of Future Past". Logan ha decidido no volver a usar sus poderes ni sus garras, pero cuando una malvada organización liderada por Nathaniel Essex intenta utilizar al resto de mutantes que quedan en el mundo, convirtiéndolos en armas para usar en su beneficio, Logan se verá obligado a volver a ser ''Wolverine'' una vez más... Tercera película protagonizada por Lobezno, que se basará en la miniserie de cómics "Wolverine: Old Man Logan", escrita por Mark Millar e ilustrada por Steve McNiven en 2008 y 2009','Prohibida para menores de 16 años con reservas',NULL);
INSERT INTO "movie" VALUES(21,'MOANA','John Musker, Ron Clements','107 minutos.','La historia se desarrolla hace dos milenios en unas islas del sur del Pacífico. La protagonista es Moana Waialiki, una joven que desea explorar el mundo navegando por el océano. Ella es la única hija de un importante capitán que pertenece a una familia con varias generaciones de marinos.','Apta todo público',NULL);
INSERT INTO "movie" VALUES(22,'SING ¡VEN Y CANTA!','Garth Jennings','108 minutos.','Buster Moon es un elegante koala que regenta un teatro que conoció tiempos mejores. Buster es un optimista nato, lo que está muy bien si no fuera un poco sinvergüenza, que ama a su teatro con pasión y es capaz de cualquier cosa para salvarlo. Sabe que el sueño de su vida está a punto de desaparecer y solo tiene una oportunidad para mantenerlo a flote: producir el concurso de canto más grande del mundo.','Apta todo público',NULL);
INSERT INTO "movie" VALUES(23,'UN CAMINO A CASA','Garth Davis','118 minutos.','Saroo Brierley es un niño que con tan sólo cinco años se perdió en las calles de Calcuta, a miles de kilómetros de casa. Tras un largo viaje acabó siendo adoptado por una pareja australiana. Veinticinco años después, con la única ayuda de Google Earth, Saroo intentará encontrar a su familia biológica.','Apta mayores de 13 años',NULL);
CREATE TABLE cinema (
	id INTEGER NOT NULL, 
	name VARCHAR(150) NOT NULL, 
	PRIMARY KEY (id)
);
INSERT INTO "cinema" VALUES(1,'CINEMA CITY');
INSERT INTO "cinema" VALUES(2,'CINEMA SAN MARTIN');
INSERT INTO "cinema" VALUES(3,'CINEMA PARADISO');
INSERT INTO "cinema" VALUES(4,'CINEMA ROCHA');
INSERT INTO "cinema" VALUES(5,'CINEMA OCHO');
CREATE TABLE movie_genre (
	movie_id INTEGER, 
	genre_id INTEGER, 
	FOREIGN KEY(movie_id) REFERENCES movie (id), 
	FOREIGN KEY(genre_id) REFERENCES genre (id)
);
INSERT INTO "movie_genre" VALUES(1,1);
INSERT INTO "movie_genre" VALUES(2,2);
INSERT INTO "movie_genre" VALUES(3,3);
INSERT INTO "movie_genre" VALUES(4,4);
INSERT INTO "movie_genre" VALUES(5,1);
INSERT INTO "movie_genre" VALUES(6,2);
INSERT INTO "movie_genre" VALUES(7,5);
INSERT INTO "movie_genre" VALUES(8,6);
INSERT INTO "movie_genre" VALUES(9,7);
INSERT INTO "movie_genre" VALUES(9,8);
INSERT INTO "movie_genre" VALUES(10,5);
INSERT INTO "movie_genre" VALUES(11,1);
INSERT INTO "movie_genre" VALUES(12,1);
INSERT INTO "movie_genre" VALUES(13,9);
INSERT INTO "movie_genre" VALUES(14,7);
INSERT INTO "movie_genre" VALUES(14,8);
INSERT INTO "movie_genre" VALUES(15,10);
INSERT INTO "movie_genre" VALUES(16,11);
INSERT INTO "movie_genre" VALUES(17,12);
INSERT INTO "movie_genre" VALUES(18,13);
INSERT INTO "movie_genre" VALUES(19,2);
INSERT INTO "movie_genre" VALUES(20,7);
INSERT INTO "movie_genre" VALUES(20,8);
INSERT INTO "movie_genre" VALUES(21,13);
INSERT INTO "movie_genre" VALUES(22,13);
INSERT INTO "movie_genre" VALUES(23,1);
CREATE TABLE showtime (
	id INTEGER NOT NULL, 
	language VARCHAR(60), 
	horary TIME NOT NULL, 
	room VARCHAR(45) NOT NULL, 
	cinema_id INTEGER, 
	movie_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(cinema_id) REFERENCES cinema (id), 
	FOREIGN KEY(movie_id) REFERENCES movie (id)
);
INSERT INTO "showtime" VALUES(1,'Castellano','14:00:00.000000','SALA DIGITAL 2D',1,1);
INSERT INTO "showtime" VALUES(2,'Castellano','18:20:00.000000','SALA DIGITAL 2D',1,1);
INSERT INTO "showtime" VALUES(3,'Castellano','20:40:00.000000','SALA DIGITAL 2D',1,1);
INSERT INTO "showtime" VALUES(4,'Castellano','23:10:00.000000','SALA DIGITAL 2D',1,1);
INSERT INTO "showtime" VALUES(5,'Inglés subtitulada','14:10:00.000000','SALA 3D',2,2);
INSERT INTO "showtime" VALUES(6,'Inglés subtitulada','18:40:00.000000','SALA 3D',2,2);
INSERT INTO "showtime" VALUES(7,'Inglés subtitulada','23:15:00.000000','SALA 3D',2,2);
INSERT INTO "showtime" VALUES(8,'Inglés subtitulada','12:00:00.000000','SALA DIGITAL 2D',2,2);
INSERT INTO "showtime" VALUES(9,'Inglés subtitulada','16:25:00.000000','SALA DIGITAL 2D',2,2);
INSERT INTO "showtime" VALUES(10,'Inglés subtitulada','20:55:00.000000','SALA DIGITAL 2D',2,2);
INSERT INTO "showtime" VALUES(11,'Inglés subtitulada','12:00:00.000000','SALA DIGITAL 2D',3,3);
INSERT INTO "showtime" VALUES(12,'Inglés subtitulada','14:15:00.000000','SALA DIGITAL 2D',3,3);
INSERT INTO "showtime" VALUES(13,'Inglés subtitulada','18:35:00.000000','SALA DIGITAL 2D',3,3);
INSERT INTO "showtime" VALUES(14,'Inglés subtitulada','20:45:00.000000','SALA DIGITAL 2D',3,3);
INSERT INTO "showtime" VALUES(15,'Castellano','12:00:00.000000','SALA DIGITAL 2D',4,4);
INSERT INTO "showtime" VALUES(16,'Castellano','15:40:00.000000','SALA DIGITAL 2D',4,4);
INSERT INTO "showtime" VALUES(17,'Castellano','19:40:00.000000','SALA DIGITAL 2D',4,4);
INSERT INTO "showtime" VALUES(18,'Castellano','21:30:00.000000','SALA DIGITAL 2D',4,4);
INSERT INTO "showtime" VALUES(19,'Francés subtitulado','12:00:00.000000','SALA DIGITAL 2D',3,5);
INSERT INTO "showtime" VALUES(20,'Francés subtitulado','16:30:00.000000','SALA DIGITAL 2D',3,5);
INSERT INTO "showtime" VALUES(21,'Francés subtitulado','20:55:00.000000','SALA DIGITAL 2D',3,5);
INSERT INTO "showtime" VALUES(22,'Castellano','12:10:00.000000','SALA DIGITAL 2D',5,6);
INSERT INTO "showtime" VALUES(23,'Castellano','17:30:00.000000','SALA DIGITAL 2D',5,6);
INSERT INTO "showtime" VALUES(24,'Castellano','14:00:00.000000','SALA DIGITAL 2D',5,6);
INSERT INTO "showtime" VALUES(25,'Castellano','20:50:00.000000','SALA DIGITAL 2D',5,6);
INSERT INTO "showtime" VALUES(26,'Castellano','23:15:00.000000','SALA DIGITAL 2D',5,6);
INSERT INTO "showtime" VALUES(27,'Inglés subtitulada','23:15:00.000000','SALA DIGITAL 2D',5,7);
INSERT INTO "showtime" VALUES(28,'Castellano','12:00:00.000000','SALA DIGITAL 2D',1,8);
INSERT INTO "showtime" VALUES(29,'Castellano','16:15:00.000000','SALA DIGITAL 2D',1,8);
INSERT INTO "showtime" VALUES(30,'Castellano','18:40:00.000000','SALA DIGITAL 2D',1,8);
INSERT INTO "showtime" VALUES(31,'Castellano','21:00:00.000000','SALA DIGITAL 2D',1,8);
INSERT INTO "showtime" VALUES(32,'Castellano','23:15:00.000000','SALA DIGITAL 2D',1,8);
INSERT INTO "showtime" VALUES(33,'Castellano','14:00:00.000000','SALA DIGITAL 2D',2,9);
INSERT INTO "showtime" VALUES(34,'finlandés subtitulado','14:30:00.000000','SALA DIGITAL 2D',3,10);
INSERT INTO "showtime" VALUES(35,'finlandés subtitulado','23:20:00.000000','SALA DIGITAL 2D',3,10);
INSERT INTO "showtime" VALUES(36,'Castellano','18:40:00.000000','SALA DIGITAL 2D',3,11);
INSERT INTO "showtime" VALUES(37,'Castellano','23:05:00.000000','SALA DIGITAL 2D',3,11);
INSERT INTO "showtime" VALUES(38,'Francés subtitulado','12:00:00.000000','SALA DIGITAL 2D',3,12);
INSERT INTO "showtime" VALUES(39,'Francés subtitulado','18:40:00.000000','SALA DIGITAL 2D',3,12);
INSERT INTO "showtime" VALUES(40,'Francés subtitulado','23:15:00.000000','SALA DIGITAL 2D',3,12);
INSERT INTO "showtime" VALUES(41,'Inglés subtitulada','14:20:00.000000','SALA DIGITAL 2D',2,13);
INSERT INTO "showtime" VALUES(42,'Inglés subtitulada','18:50:00.000000','SALA DIGITAL 2D',2,13);
INSERT INTO "showtime" VALUES(43,'Inglés subtitulada','20:50:00.000000','SALA DIGITAL 2D',2,13);
INSERT INTO "showtime" VALUES(44,'Inglés subtitulada','23:15:00.000000','SALA DIGITAL 2D',2,13);
INSERT INTO "showtime" VALUES(45,'Inglés subtitulada','20:40:00.000000','SALA 3D',4,14);
INSERT INTO "showtime" VALUES(46,'Inglés subtitulada','23:05:00.000000','SALA 3D',4,14);
INSERT INTO "showtime" VALUES(47,'Inglés subtitulada','18:05:00.000000','SALA DIGITAL 2D',4,14);
INSERT INTO "showtime" VALUES(48,'Inglés subtitulada','13:50:00.000000','SALA DIGITAL 2D',4,14);
INSERT INTO "showtime" VALUES(49,'Inglés subtitulada','12:00:00.000000','SALA DIGITAL 2D',2,14);
INSERT INTO "showtime" VALUES(50,'Castellano','14:50:00.000000','SALA 3D',1,15);
INSERT INTO "showtime" VALUES(51,'Castellano','20:15:00.000000','SALA 3D',1,15);
INSERT INTO "showtime" VALUES(52,'Castellano','12:00:00.000000','SALA DIGITAL 2D',1,15);
INSERT INTO "showtime" VALUES(53,'Castellano','17:30:00.000000','SALA DIGITAL 2D',1,15);
INSERT INTO "showtime" VALUES(54,'Castellano','23:05:00.000000','SALA DIGITAL 2D',1,15);
INSERT INTO "showtime" VALUES(55,'Castellano','14:50:00.000000','SALA 3D',5,15);
INSERT INTO "showtime" VALUES(56,'Castellano','20:30:00.000000','SALA 3D',5,15);
INSERT INTO "showtime" VALUES(57,'Castellano','12:00:00.000000','SALA DIGITAL 2D',5,15);
INSERT INTO "showtime" VALUES(58,'Castellano','17:40:00.000000','SALA DIGITAL 2D',5,15);
INSERT INTO "showtime" VALUES(59,'Castellano','23:15:00.000000','SALA DIGITAL 2D',5,15);
INSERT INTO "showtime" VALUES(60,'Castellano','12:15:00.000000','SALA 3D',3,15);
INSERT INTO "showtime" VALUES(61,'Castellano','17:40:00.000000','SALA 3D',3,15);
INSERT INTO "showtime" VALUES(62,'Castellano','23:10:00.000000','SALA 3D',3,15);
INSERT INTO "showtime" VALUES(63,'Castellano','15:00:00.000000','SALA DIGITAL 2D',3,15);
INSERT INTO "showtime" VALUES(64,'Castellano','20:25:00.000000','SALA DIGITAL 2D',3,15);
INSERT INTO "showtime" VALUES(65,'Castellano','12:00:00.000000','SALA 3D',4,15);
INSERT INTO "showtime" VALUES(66,'Castellano','23:15:00.000000','SALA 3D',4,15);
INSERT INTO "showtime" VALUES(67,'Castellano','14:50:00.000000','SALA DIGITAL 2D',4,15);
INSERT INTO "showtime" VALUES(68,'Castellano','17:40:00.000000','SALA DIGITAL 2D',4,15);
INSERT INTO "showtime" VALUES(69,'Castellano','20:30:00.000000','SALA DIGITAL 2D',4,15);
INSERT INTO "showtime" VALUES(70,'Castellano','17:40:00.000000','SALA 3D',2,15);
INSERT INTO "showtime" VALUES(71,'Castellano','23:15:00.000000','SALA 3D',2,15);
INSERT INTO "showtime" VALUES(72,'Castellano','12:10:00.000000','SALA DIGITAL 2D',2,15);
INSERT INTO "showtime" VALUES(73,'Castellano','14:55:00.000000','SALA DIGITAL 2D',2,15);
INSERT INTO "showtime" VALUES(74,'Castellano','20:25:00.000000','SALA DIGITAL 2D',2,15);
INSERT INTO "showtime" VALUES(75,'Inglés subtitulada','16:40:00.000000','SALA DIGITAL 2D',2,16);
INSERT INTO "showtime" VALUES(76,'Inglés subtitulada','21:10:00.000000','SALA DIGITAL 2D',2,16);
INSERT INTO "showtime" VALUES(77,'Inglés subtitulada','12:00:00.000000','SALA DIGITAL 2D',1,17);
INSERT INTO "showtime" VALUES(78,'Inglés subtitulada','16:10:00.000000','SALA DIGITAL 2D',1,17);
INSERT INTO "showtime" VALUES(79,'Inglés subtitulada','14:15:00.000000','SALA DIGITAL 2D',1,18);
INSERT INTO "showtime" VALUES(80,'Inglés subtitulada','16:10:00.000000','SALA 3D',4,18);
INSERT INTO "showtime" VALUES(81,'Inglés subtitulada','12:00:00.000000','SALA DIGITAL 2D',4,18);
INSERT INTO "showtime" VALUES(82,'Inglés subtitulada','13:40:00.000000','SALA DIGITAL 2D',4,19);
INSERT INTO "showtime" VALUES(83,'Inglés subtitulada','17:40:00.000000','SALA DIGITAL 2D',4,19);
INSERT INTO "showtime" VALUES(84,'Inglés subtitulada','23:20:00.000000','SALA DIGITAL 2D',4,19);
INSERT INTO "showtime" VALUES(85,'Inglés subtitulada','14:40:00.000000','SALA DIGITAL 2D',5,20);
INSERT INTO "showtime" VALUES(86,'Inglés subtitulada','20:15:00.000000','SALA DIGITAL 2D',5,20);
INSERT INTO "showtime" VALUES(87,'Inglés subtitulada','18:10:00.000000','SALA DIGITAL 2D',2,20);
INSERT INTO "showtime" VALUES(88,'Inglés subtitulada','23:20:00.000000','SALA DIGITAL 2D',2,20);
INSERT INTO "showtime" VALUES(89,'Castellano','12:00:00.000000','SALA 3D',5,21);
INSERT INTO "showtime" VALUES(90,'Castellano','16:30:00.000000','SALA 3D',5,21);
INSERT INTO "showtime" VALUES(91,'Castellano','18:40:00.000000','SALA DIGITAL 2D',5,21);
INSERT INTO "showtime" VALUES(92,'Castellano','14:05:00.000000','SALA DIGITAL 2D',3,21);
INSERT INTO "showtime" VALUES(93,'Castellano','16:20:00.000000','SALA DIGITAL 2D',3,21);
INSERT INTO "showtime" VALUES(94,'Castellano','12:00:00.000000','SALA DIGITAL 2D',2,22);
INSERT INTO "showtime" VALUES(95,'Castellano','16:10:00.000000','SALA DIGITAL 2D',2,22);
INSERT INTO "showtime" VALUES(96,'Inglés subtitulada','16:15:00.000000','SALA DIGITAL 2D',3,23);
INSERT INTO "showtime" VALUES(97,'Inglés subtitulada','21:00:00.000000','SALA DIGITAL 2D',3,23);
COMMIT;
