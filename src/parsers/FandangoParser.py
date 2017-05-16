#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import requests
import time
import datetime
import re
import iso8601

from models.Cinema import Cinema
from models.Genre import Genre
from models.Movie import Movie
from models.Showtime import Showtime

from bs4 import BeautifulSoup

def remove_3d(title):
	return re.sub('3D', '', title)

def remove_year(title):
	return re.sub(r'\([^)]*\)', '', title)

def get_year(title):
	if "(" in title:
		return title[title.find("(")+1:title.find(")")]
	else:
		return ''

class FandangoParser:

	def __init__(self, sessiondb):
		self.url = 'http://www.fandango.com/'
		self.session = requests.session()
		self.sessiondb = sessiondb

	def fill_movies(self, soup):
		movies_html = soup.findAll(attrs={'itemscope' : '', 'itemtype' : 'http://schema.org/Movie'})
		for movie in movies_html:
			title = movie.find(attrs={'itemprop':'name'})['content']
			str_year = get_year(title)
			if (len(str_year)>0):
				year = int(str_year)
			else:
				year = None
			title = remove_year(remove_3d(title)).strip()
			s = self.sessiondb()
			m = s.query(Movie).filter(Movie.title == title).first()
			if not m:
				m = Movie(title=title,year=year)
			s.add(m)
			s.commit()
			s.close()

	def fill_movie_theatre_event(self, soup, cinema):
		events = soup.findAll(attrs={'itemprop' : 'event', 'itemtype' : 'http://schema.org/TheaterEvent'})
		for event in events:
			title = event.find(attrs={'itemprop':'name'})['content']
			s = self.sessiondb()
			cinema = s.merge(cinema)
			if "3D" in title:
				room = "3D"
			else:
				room = "2D"
			title = remove_year(remove_3d(title)).strip()
			movie = s.query(Movie).filter(Movie.title == title).first()
			dates = event.findAll(attrs={'itemprop':'startDate'})
			for date in dates:
				d = date['content']
				d = iso8601.parse_date(d)
				showtime = Showtime(date=d, room=room, cinema=cinema, movie=movie)
				s.add(showtime)
				s.commit()
			s.close()

	def fill_movie_theatre(self, soup, url):
		movie_theatres = soup.findAll(attrs={'itemscope' : '', 'itemtype' : 'http://schema.org/MovieTheater'})
		for movie_theatre in movie_theatres:
			name = movie_theatre.find(attrs={'itemprop':'name'})['content']
			cinema = Cinema(name=name, url=url)
			s = self.sessiondb()
			s.add(cinema)
			s.commit()
			s.close()
			self.fill_movie_theatre_event(movie_theatre, cinema)

	def fill_db(self, url_movie_theatre):
		html = self.session.get(self.url + url_movie_theatre)
		soup = BeautifulSoup(html.text, 'lxml')
		self.fill_movies(soup)
		self.fill_movie_theatre(soup, self.url + url_movie_theatre)

