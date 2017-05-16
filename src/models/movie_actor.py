# -*- coding: utf-8 -*-

from sqlalchemy import Table, Column, Integer, ForeignKey
from models.base import Base

movie_actor = Table('movie_actor', Base.metadata,
    Column('movie_id', Integer, ForeignKey('movie.id')),
    Column('actor_id', Integer, ForeignKey('actor.id'))
)
