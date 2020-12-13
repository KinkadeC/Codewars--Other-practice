

SELECT country.country_name_eng, COUNT(city.id) AS number_of_cities
FROM country
LEFT JOIN city ON country.id = city.country_id
GROUP BY country.id, country.country_name_eng
ORDER BY country.country_name_eng ASC;

SELECT 
  customer.id,
  customer.customer_name,
  COUNT(call.id) AS calls
FROM customer
INNER JOIN call ON call.customer_id = customer.id
GROUP BY
  customer.id,
  customer.customer_name
HAVING COUNT(call.id) > (
  SELECT CAST(COUNT(*) AS DECIMAL(5,2)) / CAST(COUNT(DISTINCT customer_id) AS DECIMAL(5,2)) FROM call
);

--WHERE, HAVING
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

--CASE WHEN, Query from subtable, SUM
SELECT place from (
SELECT place, SUM(CASE WHEN opinion = 'recommended' THEN 1 ELSE -1 END) as diff
FROM opinions
GROUP BY place
HAVING diff>0)
ORDER BY place

SELECT t3.subscriber_id, t1.join_date,t2.remove_date, t2.remove_date-t1.join_date FROM subscription as t3,
--start date table
(SELECT subscriber_id, EXTRACT(DATE from completion_date_time) as join_date from subscription
WHERE order_type_name = 'new') as t1,
--start end table
(SELECT subscriber_id, EXTRACT(DATE from completion_date_time) as remove_date from subscription
WHERE order_type_name = 'remove') as t2
JOIN member ON t3.subscriber_id = member.subscriber_id
HAVING (EXTRACT(date FROM GETDATE())) - EXTRACT(date FROM member.date_of_birth)) >=40 AND
LEFT(member.first_name,1) = 'M'

--Bins using CASE WHEN | Use SUM instead depending on situation
SELECT 
Gender,
count(CASE WHEN Age>= 10 AND Age < 20 THEN 1 END) AS [10 - 20],
count(CASE WHEN Age>= 21 AND Age < 30 THEN 1 END) AS [21 - 30],
count(CASE WHEN Age>= 31 AND Age < 35 THEN 1 END) AS [31 - 35],
count(CASE WHEN Age>= 36 AND Age < 40 THEN 1 END) AS [36 - 40]
FROM Attendees AS AgeGroups
GROUP BY Gender