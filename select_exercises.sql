SHOW DATABASES;
USE albums_db;
DESCRIBE albums;
SELECT *
FROM albums;
#there are 31 rows in the albums table
SELECT DISTINCT artist
from albums;
#there are 23 unique artist names
#the primary key is the field 'id'

Select MAX(release_date) from albums;
Select MIN(release_date) from albums;
#The oldest release date is 1967 and the latest is 2011

SELECT name FROM albums WHERE artist = 'Pink Floyd';
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
SELECT genre FROM albums WHERE name = 'Nevermind';
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;
SELECT name FROM albums WHERE sales < 20;
SELECT name FROM albums WHERE genre = 'Rock';
#only albums with the genre 'Rock' appear because we narrowed the search to return albums that only have the string 'Rock' in the column and nothing else