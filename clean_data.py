#import libraries

import ast
import re
import pandas as pd
import numpy as np

#open movies dataset with pandas

movies = pd.read_csv('./movies_metadata.csv')

movies = pd.DataFrame(movies)

#create function to parse our names

def data_parse(string):
    string = str(string)
    string = str(ast.literal_eval(repr(string)))
    regex_expression = "'name': '(.*?)'"
    names = re.findall(regex_expression, string)
    return names

#apply function to dataframe

movies['genres'] = movies['genres'].apply(data_parse)
movies['production_companies'] = movies['production_companies'].apply(data_parse)
movies['production_countries'] = movies['production_countries'].apply(data_parse)
movies['spoken_languages'] = movies['spoken_languages'].apply(data_parse)

#create new table

movie_factors = movies[['id', 'genres', 'production_companies', 'production_countries', 'spoken_languages']]

#create csv

movie_factors.to_csv('movie_factors.csv')

#open credits dataset with pandas

credits = pd.read_csv('./credits.csv', usecols=['id','cast'])

credits = pd.DataFrame(credits)

#apply function to dataframe

credits['cast'] = credits['cast'].apply(data_parse)

#create new table

actors = credits[['id', 'cast']]

#create csv

actors.to_csv('actors.csv')
