use cars;
-- Which car has the highest accelerate value?
select max(c.accelerate) from cars.cars_data c;

-- List the weight of the cars made in the 1980s (1980 and later).
select c.weight from cars.cars_data c where c.year >=1980 order by c.weight;

-- List all the cars made by chevrolet (where the model is chevrolet).
select * from cars.car_names c where c.model = 'chevrolet';

-- What is the full name of the maker of the nissan model?
select c.maker, c.full_name from cars.car_makers c where c.maker = 'nissan';

-- Which continent is the Volvo car maker from?
/*we can do this in one query with join. but at the end of the module*/
select c.maker, c.country from cars.car_makers c where c.maker = 'volvo'; -- return 6
select continent from countries where id = 6; -- return 2
select continent from continents where id = 2;

-- How many car models are audi?
select model, count(*) FROM cars.car_names where model = 'audi';

-- List all makers whose names start with s.
select * from cars.car_makers c where c.full_name like 's%';

-- How many cars have a horsepower more than 100 but less than 200?
select count(*) from cars.cars_data c where c.horsepower > 100 and c.horsepower < 200;

-- List all car makers from australia.
select *
from cars.car_makers c inner join cars.countries co on c.country = co.id 
where co.name ='australia';

-- List all car makers not from sweden, japan, france or germany.
select *
from cars.car_makers c inner join cars.countries co on c.country = co.id 
where co.name not in ('france', 'germany', 'japan', 'sweden')



