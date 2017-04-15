#!/usr/bin/python
# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, String, Text, ForeignKey, Float, Time, Boolean
from sqlalchemy.orm import relationship
from models.base import Base
from models import Movie, Cinema

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
