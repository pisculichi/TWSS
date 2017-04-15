#!/usr/bin/python
# -*- coding: utf-8 -*-
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from models.base import Base
from models import *

engine = create_engine('sqlite:///cines.db')
Session = sessionmaker()
Session.configure(bind=engine)
Base.metadata.create_all(engine)
