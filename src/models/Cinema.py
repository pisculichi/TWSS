#!/usr/bin/python
# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, String, Text, ForeignKey, Float, Time, Boolean
from sqlalchemy.orm import relationship
from models.base import Base
from models import Showtime

class Cinema(Base):
	__tablename__ = 'cinema'
	id = Column(Integer, primary_key=True)
	name = Column(String(150), nullable=False)
	showtimes = relationship('Showtime')

	def __repr__(self):
		return "<Cinema(id='%d', name='%s')>" % (
			self.id, self.name)
