#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
This script reads a list of DOIs from a text file and retrieves the metadata
from the CrossRef API. The metadata is then saved as a JSON file.

The input file should have one DOI per line, with the format:
DOI: 10.1234/abcd
"""


import sys
import json
import crossref_commons.retrieval as ccr
from bs4 import BeautifulSoup
import re
import json 


class RefEntry(object):
    """
    This class beautifies the content retrieved by the CrossRef API.
    """
    def __init__(self, doi):
        self.doi = doi
        self.content = ccr.get_publication_as_json(self.doi)
        self.title = self.clean_html(self.content['title'][0])
        self.authors = self.get_authors()
        try:
            self.journal = self.clean_html(self.content['short-container-title'][0])
        except IndexError:
            self.journal = self.content['publisher']
        self.year = self.content['created']['date-parts'][0][0]
        self.abstract = self.clean_html(self.get_abstract())
        self.attributes = self.get_attributes()

    def get_authors(self):
        # return a list of authors as Surname, Name
        authors = []
        for j in self.content['author']:
            author_string = f"{j['family']} {j['given']}"
            authors.append(author_string)
        return authors
    
    def get_abstract(self):
        return self.content.get('abstract', '')

    def clean_html(self, html_string):
        # Parse the HTML content
        soup = BeautifulSoup(html_string, 'html.parser')
        text = soup.get_text()
        # Remove extra whitespace, newlines and abstract at the beginning
        clean_text = re.sub(r'\s+', ' ', text).strip()
        clean_text = re.sub(r'^abstract', '', clean_text, flags=re.IGNORECASE)
        return clean_text

    def get_attributes(self):
        return {
            'doi': self.doi,
            'title': self.title,
            'authors': self.authors,
            'journal': self.journal,
            'year': self.year,
            'abstract': self.abstract
        }

if __name__ == '__main__':
    entries = []
    with open(sys.argv[1], 'r') as doi_list:
        with open(sys.argv[2], 'r') as json_file:
            entries = json.load(json_file)
            for line in doi_list:
                doi = line.rstrip().split(': ')[1]
                # ensure the DOI is not already in the JSON file
                if any(doi in entry['doi'] for entry in entries):
                    print("DOI already in the JSON file:", doi)
                    continue
                else:
                    print("Processing DOI:", doi)
                    entry = RefEntry(doi)
                    entries.append(entry.attributes)
    with open(sys.argv[2], 'w') as json_file:
        json.dump(entries, json_file, indent=4, ensure_ascii=False)    