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
from contextlib import closing
from selenium.webdriver import PhantomJS # pip install selenium
from selenium.webdriver.support.ui import WebDriverWait

def hasNumbers(inputString):
	return bool(re.search(r'\d', inputString))

class CinemaVillageParser:
	def __init__(self, sessiondb):
		self.url = 'https://www.villagecines.com/'
		self.sessiondb = sessiondb
	
	def get_showtimes_urls(self):
		with closing(PhantomJS()) as browser:
			browser.get(self.url)
			WebDriverWait(browser, timeout=10).until(
					lambda x: x.find_element_by_class_name('movie-item'))
			html = browser.page_source
			soup = BeautifulSoup(html, 'lxml')
			links = soup.findAll('a', {'class' : 'grid-item movie-item', 'href' : True })
		return [link['href'] for link in links]

	def get_data_ficha_tecnica(self, key, ficha_tecnica):
		regex_dict = {
			'director' : 'Director: (.*?) Actores:',
			'genres' : 'Género: (.*?) Director:',
			'duration' : 'Duración: (.*?) Distribuidora:',
			'distribuidory' : 'Distribuidora: (.*?)',
			'clasification' : 'Calificación: (.*?)'
		}
		result = re.findall(regex_dict[key], ficha_tecnica)
		if len(result) > 0:
			return result[0]
		return ''

	def fill_db(self, urls_movies):
		browser = PhantomJS()
		for url_movie in urls_movies:
			browser.get(self.url + url_movie)
			WebDriverWait(browser, timeout=10).until(
				lambda x: x.find_element_by_class_name('movie-detail-filter'))
			html = browser.page_source
			soup = BeautifulSoup(html, 'lxml')
			title = soup.find('h3', { 'class' : 'title' }).text.strip().upper()
			title = re.sub( '\.', '', title).strip()
			synopsis = soup.find('div', { 'id' : 'sinopsis'}).text.strip()
			div_ficha_tecnica = soup.find('div', { 'id' : 'ficha-tecnica' })
			ficha_tecnica = div_ficha_tecnica.text
#				ficha_tecnica = " ".join(ficha_tecnica.splitlines())
			ficha_tecnica = re.sub( '\n+', ' ', ficha_tecnica).strip()
			ficha_tecnica = re.sub( '\s+', ' ', ficha_tecnica).strip()
			director = self.get_data_ficha_tecnica('director', ficha_tecnica)
			genres = self.get_data_ficha_tecnica('genres', ficha_tecnica).split(',')
			duration = self.get_data_ficha_tecnica('duration', ficha_tecnica).split(' ')[0].strip()
			calification = self.get_data_ficha_tecnica('duration', ficha_tecnica).split(' ')[0].strip()
			if hasNumbers(duration):
				duration = int(duration)
			else:
				duration = 0
			distribuidory = self.get_data_ficha_tecnica('distribuidory', ficha_tecnica)
			s = self.sessiondb()
			movie = s.query(Movie).filter(Movie.title == title).first()
			if not movie:
				movie = Movie(title=title, director=director, duration=duration, synopsis=synopsis, calification=calification)
			for genre in genres:
				gen = genre.strip()
				g = s.query(Genre).filter(Genre.name == gen).first()
				if not g:
					g = Genre(name=gen)
					s.add(g)
				movie.genres.append(g)
			s.add(movie)
			cines = soup.findAll('div', { 'class' : 'panel panel-default' })
			for cine in cines:
				name_cinema = cine.find('h4', { 'class' : 'panel-title' }).text.strip()
				cinema = s.query(Cinema).filter(Cinema.name == name_cinema).first()
				if not cinema:
					cinema = Cinema(name=name_cinema)
				s.add(cinema)
				div_salas = cine.findAll('div', { 'class' : 'board-item' })
				for div_sala in div_salas:
					room = div_sala.findAll('li')[2].text.strip()
					language = div_sala.findAll('li')[4].text.strip()
					horaries = div_sala.findAll('a', { 'class' : 'btn btn-showtime'})
					for horary in horaries:
						hh, mm= horary.text.split(':')
#						time = datetime.time(int(hh),int(mm))
						date = datetime.datetime.now()
						date = date.replace(hour=int(hh), minute=int(mm))
						showtime = Showtime(language=language, date=date, room=room, cinema=cinema, movie=movie)
						s.add(showtime)
			s.commit()
			s.close()
		browser.quit()

