#!/usr/bin/python
# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, String, Text, ForeignKey, Float, Time, Boolean
from sqlalchemy.orm import relationship
from models.base import Base
from models.movie_genre import movie_genre
from models import Genre, Showtime

class Movie(Base):
	__tablename__ = 'movie'
	id = Column(Integer, primary_key=True)
	title = Column(String(100), nullable=False)
	director = Column(String(100), nullable=True)
	duration = Column(Integer, nullable=True)
	synopsis = Column(Text, nullable=True)
	year = Column(Integer, nullable=True)
	calification = Column(String(100), nullable=True)
	distribuidory = Column(String(100), nullable=True)
	showtimes = relationship('Showtime')
	genders = relationship("Genre", secondary=movie_genre, back_populates="movies")

	def __repr__(self):
		return "<Movie(id='%d', title='%s', director='%s', duration='%d', calification='%s', distribuidory='%s')>" % (
			self.id, self.title, self.director, self.duration if self.duration else 0, self.calification, self.distribuidory)
