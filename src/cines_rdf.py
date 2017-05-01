#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
from rdflib import BNode, ConjunctiveGraph, URIRef, Literal, Namespace, RDF
from rdflib.namespace import FOAF, DC
from rdflib.collection import Collection
from models.session import Session, Cinema

SC = Namespace('http://schema.org/')
MOVIE = Namespace('http://schema.org/Movie#')
CINEMA = Namespace('http://schema.org/MovieTheatre#')
SHOWTIME = Namespace('http://schema.org/EventTheatre#')

graph = ConjunctiveGraph()
graph.bind('schema', SC)
graph.bind('movie', MOVIE)
graph.bind('movietheatre', CINEMA)

CinemaRes = graph.resource(SC.MovieTheatre)

genres_nodes = {}
directors_nodes = {}
movies_nodes = {}

def add_genre(name):
	if name not in genres_nodes:
		genre = BNode()
		graph.add((genre, RDF.type, SC.genre))
		graph.add((genre, SC.Text, Literal(name)))
		genres_nodes[name] = genre

def add_genres_movie(m, genres_movie):
	listGenres = BNode()
	for genre_movie in genres_movie:
		add_genre(genre_movie.name)
		graph.add((listGenres, RDF.Bag, genres_nodes[genre_movie.name]))
	graph.add( (m, SC.genres, listGenres) )

def add_director(name):
	if name not in directors_nodes:
		director = BNode()
		graph.add((director, RDF.type, SC.Person))
		graph.add((director, SC.Text, Literal(name)))
		directors_nodes[name] = director

def add_director_movie(m, name):
	add_director(name)
	graph.add( (m, SC.director, directors_nodes[name]) )

def add_movie(movie):
	if movie.url not in movies_nodes:
		m = URIRef(movie.url);
		movies_nodes[movie.url] = m
		graph.add( (m, RDF.type, SC.Movie) )
		add_genres_movie(m, movie.genders)
		graph.add( (m, RDF.type, SC.Movie) )
		graph.add( (m, SC.name, Literal(movie.title)) )
		graph.add( (m, SC.year, Literal(movie.year)) )
		graph.add( (m, SC.description, Literal(movie.synopsis)) )
		graph.add( (m, SC.duration, Literal('PT'+str(movie.duration)+'M')))
		add_director_movie(m, movie.director)
	return movies_nodes[movie.url]

def main(argv):
	s = Session()
	cinemas = s.query(Cinema).all()
	for cinema in cinemas:
		c = graph.resource(cinema.url)
		c.add(RDF.type, CinemaRes)
		c.add(SC.name, Literal(cinema.name))
		showtimes_bn = BNode()
		for showtime in cinema.showtimes:
			movie = showtime.movie
			m = None
			if movie.url is not None:
				sh = BNode()
				graph.add( (showtimes_bn, RDF.Bag, sh) )
				graph.add( (sh, RDF.type, SC.TheatreEvent) )
				graph.add( (sh, SC.language, Literal(showtime.language) ) )
				graph.add( (sh, SC.statDate, Literal(showtime.date) ) )
				m = add_movie(movie)
				graph.add( (sh, SC.movie, m ) )
		c.add(CINEMA.events, showtimes_bn)
	graph.serialize("cines_rdf.ttl",format='turtle')

if __name__ == "__main__":
    main(sys.argv[1:])
