#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import requests
import time
import datetime
import re

from collections import namedtuple
from bs4 import BeautifulSoup
from sqlalchemy import Table, Column, Integer, String, Text, ForeignKey, Float, Time, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from contextlib import closing
from selenium.webdriver import PhantomJS # pip install selenium
from selenium.webdriver.support.ui import WebDriverWait

Base = declarative_base()

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
			'genders' : 'Género: (.*?) Director:',
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
			genders = self.get_data_ficha_tecnica('genders', ficha_tecnica).split(',')
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
			for genre in genders:
				gen = genre.strip()
				g = s.query(Genre).filter(Genre.name == gen).first()
				if not g:
					g = Genre(name=gen)
					s.add(g)
				movie.genders.append(g)
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
						time = datetime.time(int(hh),int(mm))
						showtime = Showtime(language=language, horary=time, room=room, cinema=cinema, movie=movie)
						s.add(showtime)
			s.commit()
			s.close()
		browser.quit()

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

movie_genre = Table('movie_genre', Base.metadata,
    Column('movie_id', Integer, ForeignKey('movie.id')),
    Column('genre_id', Integer, ForeignKey('genre.id'))
)

class Movie(Base):
	__tablename__ = 'movie'
	id = Column(Integer, primary_key=True)
	title = Column(String(100), nullable=False)
	director = Column(String(100), nullable=True)
	duration = Column(Integer, nullable=True)
	synopsis = Column(Text, nullable=True)
	calification = Column(String(100), nullable=True)
	distribuidory = Column(String(100), nullable=True)
	showtimes = relationship('Showtime')
	genders = relationship("Genre", secondary=movie_genre, back_populates="movies")
	
	def __repr__(self):
		return "<Movie(id='%d', title='%s', director='%s', duration='%d', calification='%s', distribuidory='%s')>" % (
			self.id, self.title, self.director, self.duration, self.calification, self.distribuidory)

class Genre(Base):
	__tablename__ = 'genre'
	id = Column(Integer, primary_key=True)
	name = Column(String(150), nullable=False)
	movies = relationship("Movie", secondary=movie_genre, back_populates="genders")
	
	def __repr__(self):
		return "<Genre(id='%d', name='%s')>" % (
			self.id, self.name)

class Cinema(Base):
	__tablename__ = 'cinema'
	id = Column(Integer, primary_key=True)
	name = Column(String(150), nullable=False)
	showtimes = relationship('Showtime')
	
	def __repr__(self):
		return "<Cinema(id='%d', name='%s')>" % (
			self.id, self.name)

class Showtime(Base):
	__tablename__ = 'showtime'
	id = Column(Integer, primary_key=True)
	language = Column(String(60), nullable=True)
	horary = Column(Time, nullable=False)
	room = Column(String(45), nullable=False)
	cinema_id = Column(Integer, ForeignKey('cinema.id'))
	cinema = relationship('Cinema', back_populates="showtimes")
	movie_id = Column(Integer, ForeignKey('movie.id'))
	movie = relationship('Movie', back_populates="showtimes")

	def __repr__(self):
		return "<Showtime(id='%d', language='%s', room='%s')>" % (
			self.id, self.language, self.room)

def main(argv):
	engine = create_engine('sqlite:///cines.db')
	sessiondb = sessionmaker()
	sessiondb.configure(bind=engine)
	Base.metadata.create_all(engine)
	
	parser = CinemaLaPlataParser(sessiondb=sessiondb)
	urls = parser.get_showtimes_urls()
	parser.fill_db(urls_movies=urls)
	parser2 = CinemaVillageParser(sessiondb=sessiondb)
	urls = parser2.get_showtimes_urls()
	parser2.fill_db(urls_movies=urls)


if __name__ == "__main__":
    main(sys.argv[1:])



