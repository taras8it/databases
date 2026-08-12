# Databases
# Assignment 6
# Author: Oleksandr Kuprii
# Student number: 510190
# Date: 27-10-2022


import sqlite3
from pprint import pprint
from sqlite3 import Connection
from typing import Union

import task1
import task2
import task3


DATABASE_PATH = '/Users/oleksandr/Saxion/year 2/Databases/dvdrental.sqlite3'


def main(conn: Connection):
    """The main function

    :param conn: the connection to the database
    """
    task1_data = task1.fetch_customers(conn, ['Kelly', 'Edith'])

    print('Task 1')
    pprint(task1_data, compact=True)
    print('\n')

    task2.insert_customer(conn, ('Oleksandr', 'Kuprii', '510190@student.saxion.nl',
                                 True, 'M. H. Tromplaan 28', '7511 JJ', 'Enschede',
                                 'Netherlands', 'Overijssel'))

    task3_data = task3.get_top_rented_movies(conn, 7)
    print('Task 3')
    pprint(task3_data, compact=False)


def create_connection(db_path: str) -> Union[Connection, None]:
    """Create a connection to the database

    Tries to create the connection to database. If it fails, prints the exception.

    :param db_path: the path to the sqlite database
    :return: Connection if it could connect to the database, else None
    """
    try:
        return sqlite3.connect(db_path)
    except Exception as e:
        print(e)


if __name__ == '__main__':
    connection = create_connection(DATABASE_PATH)

    if connection is not None:
        main(connection)
