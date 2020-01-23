use world;

-- What is the name and the population of the most populated city in India?
SELECT c.Name, max(c.Population)
	FROM world.city c
    inner join world.country co on c.CountryCode = co.Code
    where co.Name = 'India';

-- List the names of the countries having at least 3 cities with 3 million inhabitants.
SELECT co.Name, count(c.Name)
	FROM world.city c
    inner join world.country co on c.CountryCode = co.Code
    where c.Population >= 3000000
    group by co.Name
    having count(c.Name) >= 3;
    
			/* check if the query is correct or not
			
			SELECT co.Name, c.Name
			FROM world.city c
			inner join world.country co on c.CountryCode = co.Code
			where c.Population >= 3000000
			order by co.Name;
			
			*/

-- What is the number of all the official languages?
SELECT count(0) as TotalOfficalLanguage
from world.countrylanguage cl
where cl.IsOfficial = true;

-- What is the number of all the official languages per Country?
SELECT co.Name, count(0) as NumberOfOffLanguage
from world.countrylanguage cl
inner join world.country co on cl.CountryCode = co.Code
where cl.IsOfficial = true
group by co.Name
order by co.Name;

-- List the country name and their official languages. 
SELECT co.Name, cl.Language as OffLanguage
from world.countrylanguage cl
inner join world.country co on cl.CountryCode = co.Code
where cl.IsOfficial = true
order by co.Name, cl.Language;

-- Find all the countries that have only one official language 
SELECT co.Name, count(0) as NumberOfOffLanguage
from world.countrylanguage cl
inner join world.country co on cl.CountryCode = co.Code
where cl.IsOfficial = true
group by co.Name
having NumberOfOffLanguage = 1
order by co.Name;

 -- Find which countries do not have a capital.
SELECT co.Name from world.country co
where co.Capital is null
order by co.Name;

-- Which country has the lowest population?
SELECT co.Name, co.Population
	from world.country co
	where co.Population = (SELECT min(co.Population)
							from world.country co);
		
			/* check if the query is correct or not
				SELECT co.Name, co.Population
				from world.country co
				order by  co.Population limit 10 ;
			*/

-- Make a list with all the languages spoken in Eastern Africa.
SELECT distinct co.Region, cl.Language
from world.countrylanguage cl
inner join world.country co on cl.CountryCode = co.Code
where co.Region = 'Eastern Africa'
order by cl.Language;