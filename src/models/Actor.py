#!/usr/bin/python
# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, String, Text, ForeignKey, Float, Time, Boolean
from sqlalchemy.orm import relationship
from models.base import Base
from models.movie_actor import movie_actor
from models import Movie

class Actor(Base):
	__tablename__ = 'actor'
	id = Column(Integer, primary_key=True)
	name = Column(String(150), nullable=False)
	movies = relationship("Movie", secondary=movie_actor, back_populates="actors")


	def __repr__(self):
		return "<Actor(id='%d', name='%s')>" % (
			self.id, self.name)
