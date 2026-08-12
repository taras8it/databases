--Assignment 3
--Oleksandr Kuprii 510190

--1
SELECT
	staff.first_name,
	staff.last_name
FROM
	staff
	INNER JOIN store ON staff.store_id = store.store_id;

--2
SELECT DISTINCT
	staff.first_name,
	staff.last_name
FROM
	staff
	INNER JOIN rental ON staff.staff_id = rental.staff_id
WHERE
	rental.customer_id = 256;

--3 
SELECT DISTINCT
	customer.first_name AS "Customer firstname",
	customer.last_name AS "Customer lastname",
	staff.first_name AS "Staff firstname",
	staff.last_name AS "Staff lastname"
FROM
	rental
	INNER JOIN customer ON rental.customer_id = customer.customer_id
	INNER JOIN staff ON rental.staff_id = staff.staff_id;

--4
SELECT
	film.title AS "Film title",
	category. "name" AS "Category name"
FROM
	film
	INNER JOIN film_category ON film_category.film_id = film.film_id
	INNER JOIN category ON film_category.category_id = category.category_id
ORDER BY
	category. "name",
	film.title;

--5
SELECT
	customer.first_name,
	customer.last_name,
	film.title
FROM
	rental
	INNER JOIN customer ON rental.customer_id = customer.customer_id
	INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
	INNER JOIN film ON inventory.film_id = film.film_id
ORDER BY
	customer.last_name,
	customer.first_name,
	film.title;

--6
SELECT
	customer.first_name AS "First name",
	customer.last_name AS "Last name",
	sum(amount) AS "Money spent"
FROM
	payment
	INNER JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY
	payment.customer_id
ORDER BY
	sum(amount)
	DESC;

--7
SELECT
	film.title as "Film title",
	store.address as "Store address",
	count(inventory.store_id) as "Count in stock"
FROM
	inventory
	INNER JOIN film ON inventory.film_id = film.film_id
	INNER JOIN store ON inventory.store_id = store.store_id
GROUP BY
	inventory.film_id, inventory.store_id;

--8
SELECT
	film.title AS "Film title",
	count(film_actor.actor_id) AS "Actors count"
FROM
	film_actor
	INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY
	film_actor.film_id
ORDER BY
	count(film_actor.actor_id)
	DESC;

--9
SELECT
	film.title AS "Film title",
	count(*) AS "Times rented"
FROM
	rental
	INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
	INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY
	film.film_id
ORDER BY
	count(*)
	DESC
LIMIT 10;

--10
SELECT
	*
FROM
	film
WHERE
	film_id NOT in( SELECT DISTINCT
			film_id FROM inventory
		WHERE
			inventory_id in(
				SELECT
					inventory_id FROM rental));

--11
SELECT
	title
FROM
	film
WHERE
	film_id in(
		SELECT
			film_id FROM inventory
		GROUP BY
			film_id
		HAVING
			count(*) = 8
);

--12
SELECT
	*
FROM
	customer
WHERE
	customer_id in(
		SELECT
			customer_id FROM payment
		GROUP BY
			customer_id
		HAVING
			sum(amount) > 100);

--13
SELECT
	*
FROM
	customer
WHERE
	customer_id in(
		SELECT
			customer_id FROM rental
		WHERE
			inventory_id in(
				SELECT
					inventory_id FROM inventory
				WHERE
					film_id in(
						SELECT
							film_id FROM film_category
						WHERE
							category_id in(
								SELECT
									category_id FROM category
								WHERE
									"name" = "Horror"))));

--14
SELECT
	customer.first_name,
	customer.last_name,
	count(*) AS "Count of unreturned movies"
FROM
	rental
	INNER JOIN customer ON rental.customer_id = customer.customer_id
WHERE
	rental.return_date IS NULL
GROUP BY
	rental.customer_id
HAVING
	count(*) > 1
ORDER BY
	customer.first_name,
	customer.last_name;

--15
SELECT
	film.film_id,
	film.title,
	count(*) AS "Number in inventory"
FROM
	inventory
	INNER JOIN film ON inventory.film_id = film.film_id
WHERE
	inventory.film_id in(
		SELECT
			inventory.film_id FROM rental
			INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
		GROUP BY
			inventory.film_id
		ORDER BY
			count(*)
			DESC, inventory.film_id
		LIMIT 10)
GROUP BY
	inventory.film_id;

--16
SELECT
	store.address,
	sum(payment.amount)
FROM
	payment
	INNER JOIN rental ON payment.rental_id = rental.rental_id
	INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
	INNER JOIN store ON inventory.store_id = store.store_id
GROUP BY
	inventory.store_id;

--17
SELECT
	store.address,
	count(*)
FROM
	customer
	INNER JOIN store ON customer.store_id = store.store_id
GROUP BY
	customer.store_id;

--18
SELECT
	first_name,
	last_name
FROM
	customer
UNION
SELECT
	first_name,
	last_name
FROM
	actor
UNION
SELECT
	first_name,
	last_name
FROM
	staff
ORDER BY
	last_name,
	first_name;

--19
SELECT
	first_name
FROM
	customer
INTERSECT
SELECT
	first_name
FROM
	actor
ORDER BY
	first_name;

--20
SELECT
	first_name
FROM
	actor
EXCEPT
SELECT
	first_name
FROM
	customer
ORDER BY
	first_name;
