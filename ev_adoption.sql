use ev;
select * from ev_data limit 10;
-- Total number of EV in the dataset
select count(*) from ev_data;

-- total number of unique EV manufacturers are present
select count(distinct make) as unique_manufacturers from ev_data;

-- Grouping manufacturer by number of vehicles
select make,count(*) as total_vehicles from ev_data group by make
order by total_vehicles  desc;

-- the top 10 cities with the highest EV adoption
select city,count(*) from ev_data group by city order by count(*)desc limit 10;

-- counties having the highest EV registrations
select country,count(*) as total_ev from ev_data   
group by country 
order by total_ev desc
limit 10;

-- total unique EV models exist
select model,count(*) as unique_model from ev_data 
group by model
order by unique_model desc ;
-- total count of unique model
select count(distinct model)  as total_unique_EV_Model from ev_data;

-- the average electric range of all vehicles
select avg(electric_range) as avg_electric_range from ev_data;



-- Adoption Trend Analysis
-- EV adoption changed by model year
select model_year ,count(*) as total_ev
from ev_data
group by model_year
order by model_year;

-- model year had the highest EV registrations
select model_year ,count(*) as total_ev
from ev_data
group by model_year
order by count(*) desc 
limit 1;

-- the year-over-year growth in EV adoption

WITH yearly_ev AS (SELECT 
model_year,
COUNT(*) AS total_ev
FROM ev_data
GROUP BY model_year)
SELECT model_year,total_ev,
LAG(total_ev) OVER (ORDER BY model_year) AS previous_year,
ROUND(((total_ev - LAG(total_ev) OVER (ORDER BY model_year))*100.0) 
/ LAG(total_ev) OVER (ORDER BY model_year) ,2
) AS yoy_growth_percentage
FROM yearly_ev
ORDER BY model_year;

-- EVs were registered after 2020
select count(*) as ev_registered_after2020
from ev_data
where model_year>2020;
 
-- years which saw the fastest growth in EV adoption 
SELECT Model_Year, COUNT(*) AS total_ev
FROM ev_data
GROUP BY Model_Year
ORDER BY Model_Year;

-- year to year growth
SELECT 
Model_Year,
COUNT(*) AS total_ev,
COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY Model_Year) AS yearly_growth
FROM ev_data
GROUP BY Model_Year;



-- Vehical Type Analysis
-- the average electric range for BEV vs PHEV
SELECT EV_type, avg(electric_range) as avg_ev_range
from ev_data
group by EV_type;

-- vehicle type dominates the dataset
SELECT EV_type, count(*) as total_count
from ev_data
group by EV_type;

-- cities prefer BEVs the most
select city,count(*) as total_city from ev_data
where EV_type='Battery Electric Vehicle (BEV)'
group by city
order by total_city desc;





-- Manufacturer Analysis
-- manufacturer which has the highest number of EV models
select make,count(*) as total_manufactured from ev_data
group by make order by total_manufactured desc;

-- the average electric range by manufacturer
select make, avg(electric_range) as avg_electric_range from ev_data
group by make
order by avg_electric_range desc;

-- manufacturer produces the highest range vehicles
SELECT Make, MAX(Electric_Range) AS highest_range
FROM ev_data
GROUP BY Make
ORDER BY highest_range DESC
LIMIT 1;

-- manufacturer which dominates Battery Electric Vehicles
select make,count(*)as total_bev
from ev_data
WHERE EV_Type = 'Battery Electric Vehicle (BEV)'
GROUP BY Make
ORDER BY total_bev DESC;

-- manufacturers which produce Plug-in Hybrid vehicles
select make,count(*)as total_phv
from ev_data
WHERE EV_Type ='Plug-in Hybrid Electric Vehicle (PHEV)'
GROUP BY Make
ORDER BY total_phv DESC;



-- Geographic Analysis
-- state or city has the highest EV adoption

SELECT City, COUNT(*) AS total_ev FROM ev_data
GROUP BY City
ORDER BY total_ev DESC
LIMIT 10;

SELECT State, COUNT(*) AS total_ev FROM ev_data
GROUP BY State
ORDER BY total_ev DESC;

-- top 5 cities dominate EV adoption

SELECT City, COUNT(*) AS total_ev FROM ev_data
GROUP BY City
ORDER BY total_ev DESC
LIMIT 5;

-- the average electric range by city

SELECT City, avg(electric_range) AS avg_ev FROM ev_data
GROUP BY City
ORDER BY avg_ev DESC;


-- cities have more than 1000 EVs
SELECT City, COUNT(*) AS total_ev
FROM ev_data
GROUP BY City
HAVING COUNT(*) > 1000
ORDER BY total_ev DESC;




-- Electric Range Analysis
-- the maximum electric range in the dataset
select max(electric_range) as max_electric_range 
from ev_data

-- vehicle model has the highest electric range
Select Model, Make,Electric_Range
From ev_data
Order by Electric_Range DESC
Limit 1;

-- the average electric range by model year
Select Model_Year, avg(Electric_Range) AS avg_electric_range
From ev_data
Group by Model_Year
Order by Model_Year;

-- manufacturers have average range greater than 200 miles
select make,avg(electric_range) as avg_ev_range 
from ev_data
group by make
having avg_ev_range>200;

