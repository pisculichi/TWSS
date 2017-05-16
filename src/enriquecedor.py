#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import requests
from rdflib import Graph, URIRef, Literal, Namespace, RDF, RDFS
from rdflib.namespace import FOAF, DC

SC = Namespace('http://schema.org/')
DBPEDIA = Namespace('http://dbpedia.org/resource/')
DBO = Namespace('http://dbpedia.org/ontology/')
dbpedia_resource_url =  'http://dbpedia.org/resource/'

def main(argv):
	if len(argv) != 1:
		print("Usage: python3 enriquecedor.py archivo_rdf")
		return False

	archivo = argv[0]
	graph = Graph()
	graph.load(archivo)
	MovieRes = graph.resource(SC.Movie)

	for person in graph.subjects(RDF.type, FOAF.Person):
		uri = person.toPython()
		if dbpedia_resource_url not in uri:
			continue
		uri_ = uri.replace('resource','data')
		data_graph = Graph()
		data_graph.load(uri_)

		url_wikipedia = data_graph.value(person, FOAF.isPrimaryTopicOf)
		if url_wikipedia is not None:
			graph.add((person, FOAF.isPrimaryTopicOf, Literal(url_wikipedia)))

		birthDate = data_graph.value(person, DBO.birthDate)
		if birthDate is not None:
			graph.add((person, DBO.birthDate, Literal(birthDate)))
		for movie in data_graph.subjects(DBO.starring, None):
			m = graph.resource(movie);
			m.add(RDF.type, MovieRes)
			m.add(SC.actor, person)
	graph.serialize('../data/enriquecido.rdf',format='xml')

"""
		for s,p,o in data_graph.triples( (person, FOAF.isPrimaryTopicOf, None) )
			graph.add((person,p,o))

		for s,p,o in data_graph.triples( (person, FOAF.isPrimaryTopicOf, None) )
			graph.add((person,p,o))

		graph.subjects(FOAF.isPrimaryTopicOf, )
		print(data_graph.serialize(format='turtle'))
"""

if __name__ == "__main__":
    main(sys.argv[1:])
