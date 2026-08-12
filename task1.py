"""The module for task 1."""
from sqlite3 import Connection
from typing import Collection


def fetch_customers(conn: Connection, names: Collection[str]) -> list[tuple]:
    """Fetch customers filtered by first_name

    :param conn: the connection to the database
    :param names: the collection of first names to filter on
    :return: result of the query
    """
    query = ''' SELECT * 
                FROM customer
                WHERE first_name in (%s)
                ORDER BY last_name
            ''' % ','.join('?' * len(names))

    c = conn.cursor()
    c.execute(query, names)
    return c.fetchall()
