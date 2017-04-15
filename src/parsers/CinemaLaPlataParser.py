#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import requests
import time
import datetime
import re

from models.Cinema import Cinema
from models.Genre import Genre
from models.Movie import Movie
from models.Showtime import Showtime

from bs4 import BeautifulSoup

def hasNumbers(inputString):
	return bool(re.search(r'\d', inputString))

class CinemaLaPlataParser:
	def __init__(self, sessiondb):
		self.url = 'http://www.cinemalaplata.com/'
		self.session = requests.session()
		self.sessiondb = sessiondb
	
	def contains_language(self, str_horario, language):
		return (str_horario.find(language) != -1)
	
	def horarios(self, str_horario):
		horarios_tot = []
		for line in str_horario.split('\n'):
			if len(line.strip())==0:
				continue
			if self.contains_language(line,"CASTELLANO") or self.contains_language(line,"SUBTITULADA"):
				line = re.sub('[A-Z ]+:','',line).strip()
			horarios = [x.strip() for x in line.strip().split('-')]
			horarios_tot += horarios
		return horarios_tot
	
	def get_showtimes_urls(self):
		urls_movies = []
		showtimes_html = self.session.get(self.url + 'Cartelera.aspx')
		soup = BeautifulSoup(showtimes_html.text, 'lxml')
		div_content = soup.find('div', {'id' : 'content'})
		showtime_containers = div_content.findAll('div', {'class' : 'page-container'})
		for showtime_container in showtime_containers:
			url_movie = showtime_container.findAll('a', href=True)
			urls_movies.append(url_movie[0]['href'])
		return urls_movies
	
	def fill_db(self, urls_movies):
		for url_movie in urls_movies:
			html_movie = self.session.get(self.url + url_movie)
			soup = BeautifulSoup(html_movie.text, 'lxml')
			div_content = soup.find('div', {'id' : 'content'})
			title = div_content.find('div', {'class':'post-container page-title'}).text.strip().upper()
			title = re.sub( '\.', '', title).strip()
			genders = re.split(', |- |/ |-' , div_content.find('span', {'id' : 'ctl00_cph_lblGenero'}).text)
			language = div_content.find('span', {'id' : 'ctl00_cph_lblIdioma'}).text.strip()
			duration = div_content.find('span', {'id' : 'ctl00_cph_lblDuracion'}).text.strip().split(' ')[0]
			if hasNumbers(duration):
				duration = int(duration)
			else:
				duration = 0
			synopsis = div_content.find('span', {'id' : 'ctl00_cph_lblSinopsis'}).text.strip()
			director = div_content.find('span', {'id' : 'ctl00_cph_lblDirector'}).text.strip()
			calification = div_content.find('span', { 'id' : 'ctl00_cph_lblCalificacion'}).text.strip()
			s = self.sessiondb()
			movie = s.query(Movie).filter(Movie.title == title).first()
			if not movie:
				movie = Movie(title=title, director=director, duration=duration, synopsis=synopsis, calification=calification)
			for genre in genders:
				gen = genre.strip()
				g = s.query(Genre).filter(Genre.name == gen).first()
				if not g:
					g = Genre(name=gen)
					s.add(g)
				movie.genders.append(g)
			s.add(movie)
			div_cinemas = div_content.findAll('div', { 'class':'col-2' })
			for div_cinema in div_cinemas:
				name_cinema = div_cinema.find('a',href=True).contents[0].strip()
				room = div_cinema.find('h5').text.replace('- ','').strip().replace(name_cinema,'').strip()
				cinema = s.query(Cinema).filter(Cinema.name == name_cinema).first()
				if not cinema:
					cinema = Cinema(name=name_cinema)
				s.add(cinema)
				horaries = self.horarios(div_cinema.find('p').text)
				for horary in horaries:
					try:
						hh, mm= horary.split(':')
						time = datetime.time(int(hh),int(mm))
						showtime = Showtime(language=language, horary=time, room=room, cinema=cinema, movie=movie)
						s.add(showtime)
					except ValueError:
						print("Error en el horario")
						print(cinema)
						print(movie)
						print(horaries)
						continue
			s.commit()
			s.close()

