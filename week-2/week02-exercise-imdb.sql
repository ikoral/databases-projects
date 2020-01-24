use imdb;

-- Find the minimum and the maximum age of the actors per gender.
select gender, min(age) as minimum_age, max(age) as maximum_age
from imdb.actors
group by gender;

-- Find how many actors are in their 20’s, 30’s, 40’s, 50’s etc (grouped by decade).
select age - mod(age, 10) as age_as_decade, count(0)
from imdb.actors a
group by age_as_decade
order by age_as_decade;

-- Add a column to the films table for storing the duration (runtime) or each film.
-- I think we can store duration as seconds, then I used int (size should be enough).
alter table imdb.films
add duration int;

-- Alter the data type of column age to INT.
alter table imdb.actors
modify age int;

-- Print the names and biographies of the actors in this format “ANNE HATHAWAY BIO: 1 golden globe”
select concat(UCASE(a.fname), ' ', UCASE(a.lname), ' BIO: ', a.biography) as act_bio
from imdb.actors a;

-- Delete the column biography from act
alter table imdb.actors
drop column biography;