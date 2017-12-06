-- movie project data staging
-- author: shan he
-- date: 12/05/2017

-- combine movie metadata

-- 1. check inclusiveness of data sets
select count(distinct id) from movies_metadata;
-- 45475

select count(distinct movieid) from movies;
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

-- movies_metadata and movies. movies table contains non-json genres
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

-- 3. create baseline table for analyses (excluding JSON fields)

drop table movie_baseline;

create table movie_baseline as
select distinct
      adult,
      --belongs_to_collection,
      budget,
      --a.genres,
      --homepage,
      a.tmdb_id,
      a.imdb_id,
      original_language,
      original_title,
      --overview,
      popularity,
      --poster_path,
      --production_companies,
      --production_countries,
      release_date,
      revenue,
      runtime,
      -- spoken_languages,
      status,
      --tagline,
      a.title,
      video,
      vote_average,
      vote_count
      --c.genres as genres_n
from movies_metadata a
left join links b
on a.tmdb_id = b.tmdb_id
left join movies c
on b.movie_id = c.movie_id
where a.tmdb_id is not null
and cast(a.tmdb_id as int) is not null
;

-- 4. create normalized lookup tables with split rows

-- check uniqueness of tmdb_id in actors
select tmdb_id, actor, count(*) ct
from actors
group by tmdb_id
having ct > 1
;

-- 43 rows

-- check uniqueness of tmdb_id in movie_factors
select tmdb_id, count(*) ct
from movie_factors
group by tmdb_id
having ct > 1
;

-- 29 rows

-- dedupe actors
drop table actors_dedupe;

create table actors_dedupe as
select distinct tmdb_id, actor from actors
;

-- dedupe movie_factors
drop table movie_factors_dedupe;

create table movie_factors_dedupe as
select distinct tmdb_id, genres, prod_co, prod_country, language from movie_factors
;

-- QC uniqueness
select tmdb_id, count(*) ct
from actors_dedupe
group by tmdb_id
having ct > 1
;
-- good

select tmdb_id, count(*) ct
from movie_factors_dedupe
group by tmdb_id
having ct > 1
;
-- good

-- actors normalized
drop table lkp_actor;

create table lkp_actor as
select tmdb_id, actors
from actors_dedupe lateral view explode(split(actor,', ')) actor as actors
;

-- genre normalized
drop table lkp_genre;

create table lkp_genre as
select tmdb_id, genre
from movie_factors_dedupe lateral view explode(split(genres,', ')) genres as genre
;

-- genre normalized
drop table lkp_lan;

create table lkp_lan as
select tmdb_id, lan
from movie_factors_dedupe lateral view explode(split(language,', ')) language as lan
;


-- production company normalized
drop table lkp_pro_co;

create table lkp_pro_co as
select tmdb_id, pro_co
from movie_factors_dedupe lateral view explode(split(prod_co,', ')) prod_co as pro_co
;

-- production country normalized
drop table lkp_pro_country;

create table lkp_pro_country as
select tmdb_id, pro_country
from movie_factors_dedupe lateral view explode(split(prod_country,', ')) prod_country as pro_country
;


-- 5. All-inclusive Table

-- check uniquess of movie_baseline
drop table movie_all;

create table movie_all as
select a.*,
       b.genre,
       --c.lan
       d.pro_co,
       e.pro_country,
       f.actors
from movie_baseline a
join lkp_genre b
on a.tmdb_id = b.tmdb_id
-- join lkp_lan c
-- on a.tmdb_id = c.tmdb_id
join lkp_pro_co d
on a.tmdb_id = d.tmdb_id
join lkp_pro_country e
on a.tmdb_id = e.tmdb_id
join lkp_actor f
on a.tmdb_id = f.tmdb_id
;

select count(*) from movie_all;
-- 6910651
