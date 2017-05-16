#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import requests
import re
import json

from models.Genre import Genre
from models.Movie import Movie
from models.Actor import Actor

from bs4 import BeautifulSoup

class ImdbParser:

	def __init__(self, sessiondb):
		self.url = 'http://www.imdb.com/'
		self.session = requests.session()
		self.sessiondb = sessiondb

	def get_url_imdb_movie(self, movie):
		year = movie.year
		if year:
			year_str=str(year)
		else:
			year_str=''
		resp = requests.get('http://www.omdbapi.com/?t='+movie.title+'&y='+year_str).text
		imdb_data = json.loads(resp)
		if 'Error' not in imdb_data:
			return self.url + 'title/' + imdb_data['imdbID']
		else:
			return None

	def fill_movie(self, url_imdb, movie):
		if url_imdb is None:
			return
		html = requests.get(url_imdb, headers={"Accept-Language": "en-US,en;q=0.5"})
		soup = BeautifulSoup(html.text, 'lxml')
		movie_html = soup.find(attrs={'itemscope' : '', 'itemtype' : 'http://schema.org/Movie'})
		if movie_html:
			s = self.sessiondb()
			movie = s.merge(movie)
			movie.url = url_imdb

			duration = movie_html.find(attrs={'itemprop':'duration'})
			if duration is not None:
				duration = duration['datetime']
				movie.duration = int(re.sub('[a-zA-Z]', '', duration))

			calification = movie_html.find(attrs={'itemprop':'contentRating'})
			if calification is not None:
				movie.calification = calification['content']

			genres = movie_html.findAll(attrs={'class':'itemprop', 'itemprop':'genre'})
			for genre in genres:
				g = genre.text
				gen = s.query(Genre).filter(Genre.name == g).first()
				if not gen:
					gen = Genre(name=g)
					s.add(gen)
				movie.genres.append(gen)

			actors = movie_html.findAll(attrs={'itemprop':'actors', 'itemtype': 'http://schema.org/Person' })
			for actor in actors:
				actor_name = actor.find(attrs={'itemprop':'name'}).text.strip()
				a = s.query(Actor).filter(Actor.name == actor_name).first()
				if not a:
					a = Actor(name=actor_name)
					s.add(a)
				movie.actors.append(a)

			director_html = movie_html.find(attrs={'itemprop' : 'director', 'itemtype' : 'http://schema.org/Person'})
			if director_html is not None:
				director = director_html.find(attrs={'itemprop' : 'name'}).text.strip()
				movie.director = director

			year = movie_html.find(attrs={'itemprop' : 'datePublished'})
			if year is not None:
				year = year['content'].split('-')[0]
				movie.year = int(year)

			synopsis = movie_html.find(attrs={'itemprop' : 'description'})
			if synopsis is not None:
				movie.synopsis = synopsis.text.strip()

			s.commit()
			s.close
		else:
			print('No se ha podido obtener información de la api omdbapi')
			print(movie)

	def fill_db(self):
		s = self.sessiondb()
		movies = s.query(Movie).all()
		s.close()
		for movie in movies:
			url_imdb_movie = self.get_url_imdb_movie(movie)
			self.fill_movie(url_imdb_movie, movie)
