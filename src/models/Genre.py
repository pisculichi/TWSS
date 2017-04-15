#!/usr/bin/python
# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, String, Text, ForeignKey, Float, Time, Boolean
from sqlalchemy.orm import relationship
from models.base import Base
from models.movie_genre import movie_genre
from models import Movie

class Genre(Base):
	__tablename__ = 'genre'
	id = Column(Integer, primary_key=True)
	name = Column(String(150), nullable=False)
	movies = relationship("Movie", secondary=movie_genre, back_populates="genders")

	def __repr__(self):
		return "<Genre(id='%d', name='%s')>" % (
			self.id, self.name)
