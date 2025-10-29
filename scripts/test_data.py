from psycopg import Connection
from psycopg.rows import TupleRow
from test_data_generator import *


def load_test_addresses(conn: Connection[TupleRow]):
    with conn.cursor() as c:
        c.executemany(
            '''
            INSERT INTO address (country, state, city, street, number, postal_code, complement)
            VALUES (%s, %s, %s, %s, %s, %s, %s)''',
            get_data(addresses, ['country', 'state', 'city', 'street', 'number', 'postal_code', 'complement'])
        )

    print('Test addresses initialized')