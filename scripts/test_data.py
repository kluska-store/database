from psycopg import Connection
from psycopg.rows import TupleRow
import test_data_generator as test_data


def load_test_addresses(conn: Connection[TupleRow]):
    with conn.cursor() as c:
        c.executemany(
            '''
            INSERT INTO address (country, state, city, street, number, postal_code, complement)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            ''', test_data.addresses[['country', 'state', 'city', 'street', 'number', 'postal_code', 'complement']]
            .itertuples(index=False, name=None)
        )

    print('Test addresses initialized')