"""The module for task 2."""
from sqlite3 import Connection
from typing import Collection


def insert_customer(conn: Connection, customer_data: Collection):
    """Insert a customer

    :param conn: the connection to the database
    :param customer_data: the collection of the values for a new customer. Must have a
        length of 10
    :raise ValueError: when the length of customer_data is not equal to 9
    """
    if len(customer_data) != 9:
        raise ValueError("The length of customer_data must be 9.")

    query = f''' INSERT INTO customer
                VALUES ({','.join('?' * 11)})'''

    c = conn.cursor()
    customer_id = create_customer_id(conn)
    store_id = get_store_id(conn)
    c.execute(query, (customer_id, store_id, *customer_data))
    conn.commit()


def create_customer_id(conn: Connection) -> int:
    """Get the customer id for the new entry

    :param conn: the connection to the database
    :return: the new customer id
    """
    query = ''' SELECT MAX(customer_id)
                FROM customer'''

    c = conn.cursor()
    c.execute(query)
    customer_id = c.fetchone()[0]

    return customer_id + 1


def get_store_id(conn: Connection) -> int:
    """Get the first store id from the database

    :param conn: the connection to the database
    :return: the store id
    """
    query = ''' SELECT store_id
                FROM store
                LIMIT 1'''

    c = conn.cursor()
    c.execute(query)
    return c.fetchone()[0]
