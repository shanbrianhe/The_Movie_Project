#load_data_lake.sh
#Shan He

#ReadMe
#run script with load_data_lake.sh <directory to raw files> <directory to EC2 security key pair> <EC2 Public DNS>
#locate directory for raw data
cd $1

#set up files for loading

mkdir data_for_loading
tail -n +2 credits.csv > data_for_loading/credits.csv
tail -n +2 links.csv > data_for_loading/links.csv
tail -n +2 movies_metadata.csv > data_for_loading/movies_metadata.csv
tail -n +2 keywords.csv > data_for_loading/keywords.csv
tail -n +2 links_small.csv > data_for_loading/links_small.csv
tail -n +2 ratings_small.csv > data_for_loading/links_small.csv

#transfer files to EC2 from local machine
#on local machine
scp -r -i ~/foo.pem ~/Desktop/w205/Final_Project/Raw_Data/the-movies-dataset/data_for_loading/*.csv root@ec2-34-207-148-31.compute-1.amazonaws.com:/data/movie_project

#log into EC2 instance
cd $2
ssh -i foo.pem root@$3

#create HDFS folders
su - w205
hdfs dfs -mkdir /user/w205/movie_project
hdfs dfs -mkdir /user/w205/movie_project/credits
hdfs dfs -mkdir /user/w205/movie_project/links
hdfs dfs -mkdir /user/w205/movie_project/movies_metadata
hdfs dfs -mkdir /user/w205/movie_project/keywords
hdfs dfs -mkdir /user/w205/movie_project/links_small
hdfs dfs -mkdir /user/w205/movie_project/ratings_small

#put base files into hdfs
cd /data/movie_project
hdfs dfs -put credits.csv /user/w205/movie_project/credits
hdfs dfs -put links.csv /user/w205/movie_project/links
hdfs dfs -put movies_metadata.csv /user/w205/movie_project/movies_metadata
hdfs dfs -put keywords.csv /user/w205/movie_project/keywords
hdfs dfs -put links_small.csv /user/w205/movie_project/links_small
hdfs dfs -put ratings_small.csv /user/w205/movie_project/ratings_small

#check whether all base files are transferred
hdfs dfs -ls -R /user/w205/movie_project/
