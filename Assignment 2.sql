--Assignment 2
--Oleksandr Kuprii 510190


--1
SELECT
	count(*) AS total_customers
FROM
	customer;

--2
SELECT
	sum(amount) AS turnover
FROM
	payment
WHERE
	customer_id = 148;

--3
SELECT
	round(avg(length)) AS average_duration
FROM
	film;

--4
SELECT
	max(length) AS duration
FROM
	film;

--5
SELECT
	release_year,
	count(*)
FROM
	film
GROUP BY
	release_year;

--6
SELECT
	customer_id,
	sum(amount) AS turnonver
FROM
	payment
GROUP BY
	customer_id
ORDER BY
	turnonver;

--7
SELECT
	category_id,
	count(*)
FROM
	film_category
WHERE
	category_id < 10
GROUP BY
	category_id
ORDER BY
	count(*);

--8
SELECT
	*
FROM
	rental
WHERE
	rental_date > date('2006-01-01');

--9
SELECT
	rental_id,
	JULIANDAY (return_date) - JULIANDAY (rental_date) AS duration
FROM
	rental
WHERE
	rental_date > datetime ('2005-07-01 22:00')
	AND rental_date < datetime ('2005-07-05 23:00')
ORDER BY
	duration DESC;

--10
SELECT
	strftime('%H', payment_date) AS period,
	sum(amount) AS turnover
FROM
	payment
GROUP BY
	period
ORDER BY
	turnover DESC;

--11
SELECT
	date(payment_date) AS period,
	sum(amount) AS turnover
FROM
	payment
GROUP BY
	date(payment_date)
ORDER BY
	period;

--12
SELECT
	strftime('%m', payment_date) AS period,
	sum(amount) AS turnover
FROM
	payment
GROUP BY
	period
ORDER BY
	turnover DESC;

--13
SELECT
	avg(JULIANDAY(return_date) - JULIANDAY(rental_date)) AS duration
FROM
	rental;

--14
SELECT
	customer_id,
	strftime('%m', rental_date) AS month,
	strftime('%Y', rental_date) AS year,
	count(*) AS total
FROM
	rental
GROUP BY
	customer_id,
	year,
	month
ORDER BY
	year,
	month,
	total DESC;

--15 
INSERT INTO customer (store_id, first_name, last_name, email, activebool, address, zipcode, city, country, district)
		values(1, 'Oleksandr', 'Kuprii', '510190@student.saxion.nl', 1, 'M.H. Tromplaan 28', '7513 AB', 'Enschede', 'Netherlands', 'Overijssel');

--16
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
		values(datetime (), 4181, 600, 1), (datetime (), 1840, 600, 1);

--17
INSERT INTO film (title, description, release_year, rental_duration, rental_rate, length, replacement_cost, rating, special_features, fulltext)
		values('Going Dutch', 'Description placeholder', 2022, 5, 3, 140, 25, 'G', '{Trailers}', "'canadian':19 'find':14");

--18
INSERT INTO film_category
		values(1002, 11), (1002, 5);

--19
UPDATE
	customer
SET
	address = '105 Petronas Street',
	zipcode = '5326',
	city = 'Kuala Lumpur',
	country = 'Malaysia'
WHERE
	first_name = 'Bernard'
	AND last_name = 'Colby';

--20
UPDATE
	rental
SET
	return_date = datetime ()
WHERE
	rental_id in(16052, 16053);

--21
UPDATE
	film
SET
	release_year = 2002
WHERE
	title = 'Factory Dragon';

--22
UPDATE
	film
SET
	rental_duration = 10
WHERE
	release_year >= 1980
	AND release_year <= 1985;

--23 
DELETE FROM rental
WHERE customer_id = 600;
DELETE FROM customer
WHERE customer_id = 600;

--24 
DELETE FROM film_category
WHERE film_id = 1002;
DELETE FROM film
WHERE film_id = 1002;

