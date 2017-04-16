#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys

from models.session import Session
#from parsers.CinemaLaPlataParser import CinemaLaPlataParser
#from parsers.CinemaVillageParser import CinemaVillageParser
from parsers.FandangoParser import FandangoParser
from parsers.ImdbParser import ImdbParser

def main(argv):
#	parser = CinemaLaPlataParser(sessiondb=Session)
#	urls = parser.get_showtimes_urls()
#	parser.fill_db(urls_movies=urls)
#	parser2 = CinemaVillageParser(sessiondb=Session)
#	urls = parser2.get_showtimes_urls()
#	parser2.fill_db(urls_movies=urls)
	fandangoParser = FandangoParser(sessiondb=Session)
	fandangoParser.fill_db('regalunionsquarestadium14_aajnk/theaterpage')
	imdbParser = ImdbParser(sessiondb=Session)
	imdbParser.fill_db()

if __name__ == "__main__":
    main(sys.argv[1:])



