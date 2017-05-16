#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import requests
from rdflib import BNode, ConjunctiveGraph, URIRef, Literal, Namespace, RDF, RDFS
from rdflib.namespace import FOAF, DC
from rdflib.collection import Collection
from models.session import Session, Cinema

LOCAL = Namespace('http://pisculichi.com/resource/')
SC = Namespace('http://schema.org/')
MOVIE = Namespace('http://schema.org/Movie#')
CINEMA = Namespace('http://schema.org/MovieTheatre#')
SCREENINGEVENT = Namespace('http://schema.org/ScreeningEvent#')
EVENT = Namespace('http://schema.org/Event#')
DBPEDIA = Namespace('http://dbpedia.org/resource/')

dbpedia_page_url = 'http://dbpedia.org/page/'
dbpedia_resource_url =  'http://dbpedia.org/resource/'
local_url = 'http://pisculichi.com/resource/'

graph = ConjunctiveGraph()
graph.bind('schema', SC)
graph.bind('movie', MOVIE)
graph.bind('movietheater', CINEMA)
graph.bind('screeningevent', SCREENINGEVENT)
graph.bind('event', EVENT)

CinemaRes = graph.resource(SC.MovieTheater)
EventTheaterRes = graph.resource(SC.EventTheater)
MovieRes = graph.resource(SC.Movie)

genres_nodes = {}
directors_nodes = {}
movies_nodes = {}
actor_nodes = {}

def movie_uri(movie):
	return get_uri(movie.title)

def actor_uri(actor):
	return get_uri(actor.name)

def get_uri(name):
	s = requests.session()
	slug_name = name.replace(' ','_')
	response = s.get(dbpedia_page_url + slug_name)
	url_parts = response.url.split('/')
	if response.status_code == requests.codes.ok:
		return URIRef(DBPEDIA[url_parts[len(url_parts)-1]])
	else:
		return URIRef(LOCAL[url_parts[len(url_parts)-1]])

def add_genre(name):
	if name not in genres_nodes:
		genre = get_uri(name+' film')
		graph.add((genre, RDF.type, SC.genre))
		graph.add((genre, SC.Text, Literal(name)))
		genres_nodes[name] = genre

def add_genres_movie(m, genres_movie):
	for genre_movie in genres_movie:
		add_genre(genre_movie.name)
		m.add(SC.genre, genres_nodes[genre_movie.name])

def add_actors_movie(m, actors_movie):
	for actor in actors_movie:
		add_actor(actor)
		m.add(SC.actor, actor_nodes[actor.id])

def add_director(name):
	if name not in directors_nodes:
		director = get_uri(name)
		graph.add((director, RDF.type, FOAF.Person))
		graph.add((director, RDF.type, SC.Person))
		graph.add((director, SC.name, Literal(name)))
		directors_nodes[name] = director

def add_actor(actor):
	if actor.id not in actor_nodes:
		a = get_uri(actor.name)
		graph.add((a, RDF.type, FOAF.Person))
		graph.add((a, RDF.type, SC.Person))
		graph.add((a, SC.name, Literal(actor.name)))
		actor_nodes[actor.id] = a

def add_director_movie(m, name):
	if name is not None:
		add_director(name)
		m.add(SC.director, directors_nodes[name])

def add_movie(movie):
	if movie.id not in movies_nodes:
		uri = movie_uri(movie)
		m = graph.resource(uri);
		movies_nodes[movie.id] = m
		m.add(RDF.type, MovieRes)
		add_genres_movie(m, movie.genres)
		add_actors_movie(m, movie.actors)
		m.add(RDFS.seeAlso, Literal(movie.url))
		m.add(SC.name, Literal(movie.title))
		m.add(SC.year, Literal(movie.year))
		m.add(SC.description, Literal(movie.synopsis))
		m.add(SC.duration, Literal('PT'+str(movie.duration)+'M'))
		add_director_movie(m, movie.director)
	return movies_nodes[movie.id]

def main(argv):
	s = Session()
	cinemas = s.query(Cinema).all()
	for cinema in cinemas:
		c = graph.resource(cinema.url)
		c.add(RDF.type, CinemaRes)
		c.add(SC.name, Literal(cinema.name))
		for showtime in cinema.showtimes:
			movie = showtime.movie
			m = None
			if movie.url is not None:
				m = add_movie(movie)
				sh = URIRef(LOCAL['showtime_'+str(showtime.id)])
				graph.add( (sh, RDF.type, SC.ScreeningEvent) )
				graph.add( (sh, EVENT.startDate, Literal(showtime.date) ) )
				graph.add( (sh, SCREENINGEVENT.workPresented, m.identifier))
				graph.add( (sh, SCREENINGEVENT.videoFormat, Literal(showtime.room)))
				c.add(CINEMA.events, sh)
	graph.serialize("../data/cinema-pisculichi.rdf", format='xml')

if __name__ == "__main__":
    main(sys.argv[1:])
