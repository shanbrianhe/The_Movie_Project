# The Movie Project
Predictors for Movie Box Office Success

**Introduction:**

This project looks at the public movie metadata (from Tmdb) and user ratings (MovieLens | GroupLens) to analyze predictors of the movie revenue.

**Source Data:**

https://drive.google.com/drive/u/1/folders/15oQXi-hZxMLFGqLtCPVHftqMkciz4DWT (access with berkeley email address)

**Important Scripts:**  

*clean_data.py* - python script to normalize JSON strings in source data

*data_loading.sh* - bash script to create folder structure in HDFS and load data from local machine

*hive_base_ddl.sql* - sql script to create tables and impose schema based on the source data

*data_staging.sql* - sql script to stage tables for analysis

*ML_Model/movie_project_ML_modeling* - ipython notebook that constructs Machine Learning Models for collected data



