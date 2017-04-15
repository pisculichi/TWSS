#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys

from models.session import Session
from parsers.CinemaLaPlataParser import CinemaLaPlataParser
from parsers.CinemaVillageParser import CinemaVillageParser


def main(argv):
	parser = CinemaLaPlataParser(sessiondb=Session)
	urls = parser.get_showtimes_urls()
	parser.fill_db(urls_movies=urls)
	parser2 = CinemaVillageParser(sessiondb=Session)
	urls = parser2.get_showtimes_urls()
	parser2.fill_db(urls_movies=urls)


if __name__ == "__main__":
    main(sys.argv[1:])



