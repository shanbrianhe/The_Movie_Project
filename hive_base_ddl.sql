-- Create Raw Tables for Movie Project
-- Author: Shan He
-- Date: 10/18/2017

DROP TABLE credits;

CREATE EXTERNAL TABLE credits
(
movie_cast string,
crew string,
id string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/movie_project/credits'
;

DROP TABLE keywords;

CREATE EXTERNAL TABLE keywords
(
id string,
keywords string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/movie_project/keywords'
;

DROP TABLE links_small;

CREATE EXTERNAL TABLE links_small
(
movie_id string,
imdb_id string,
tmdb_id string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/movie_project/links_small'
;

DROP TABLE links;

CREATE EXTERNAL TABLE links
(
movie_id string,
imdb_id string,
tmdb_id string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/movie_project/links'
;

DROP TABLE movies_metadata;

CREATE EXTERNAL TABLE movies_metadata
(
adult string,
belongs_to_collection string,
budget string,
genres string,
homepage string,
id string,
imdb_id string,
original_language string,
original_title string,
overview string,
popularity string,
poster_path string,
production_companies string,
production_countries string,
release_date string,
revenue string,
runtime string,
spoken_languages string,
status string,
tagline string,
title string,
video string,
vote_average string,
vote_count string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/movie_project/movies_metadata'
;

DROP TABLE ratings_small;

CREATE EXTERNAL TABLE ratings_small
(
user_id string,
movie_id string,
rating string,
timestamp string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/movie_project/ratings_small'
;

DROP TABLE movies;

CREATE EXTERNAL TABLE movies
(
movieid string,
title string,
genres string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\
'
)
STORED AS TEXTFILE
LOCATION '/user/w205/movie_project/movies'
;
