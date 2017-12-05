-- Movie Project Analysis
-- Author: Shan He
-- Date: 12/05/2017

-- combine movie metadata

-- 1. check inclusiveness of data sets
SELECT count(distinct id) FROM movies_metadata;
-- 45475

SELECT count(distinct movieid) from movies;
-- 27278

-- 2. check orphans

-- movies_metadata and links

select count(a.tmdb_id)
from movies_metadata a
left join links b
on a.tmdb_id = b.tmdb_id
where a.tmdb_id is not null
and cast(a.tmdb_id as int) is not null
and b.tmdb_id is null
;
-- 0 rows, good

-- movies_metadata and movies. movies table contains non-JSON genres
select sum(case when c.genres is null then 0 else 1 end) as matched
       , sum(case when c.genres is null then 1 else 0 end) as not_matched
from movies_metadata a
left join links b
on a.tmdb_id = b.tmdb_id
left join movies c
on b.movie_id = c.movie_id
where a.tmdb_id is not null
and cast(a.tmdb_id as int) is not null
;
-- 26992 matched
-- 18533 not_matched

-- 3. Create baseline table for analyses

drop table movie_baseline;

create table movie_baseline as
select
      adult,
      belongs_to_collection,
      budget,
      a.genres,
      homepage,
      a.tmdb_id,
      a.imdb_id,
      original_language,
      original_title,
      overview,
      popularity,
      poster_path,
      production_companies,
      production_countries,
      release_date,
      revenue,
      runtime,
      spoken_languages,
      status,
      tagline,
      a.title,
      video,
      vote_average,
      vote_count,
      c.genres as genres_n
from movies_metadata a
left join links b
on a.tmdb_id = b.tmdb_id
left join movies c
on b.movie_id = c.movie_id
where a.tmdb_id is not null
and cast(a.tmdb_id as int) is not null
;
