"""The module for task 3."""
from sqlite3 import Connection


def get_top_rented_movies(conn: Connection, limit=10) -> list[tuple]:
    """Get top rented movies

    :param conn: the connection to the database
    :param limit: the number of entries to fetch, default is 10
    :return: result of the query
    """
    query = ''' SELECT 
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
                LIMIT ?'''

    c = conn.cursor()
    c.execute(query, (limit, ))
    return c.fetchall()
