from seed_data import load_payment_methods
from test_data import *
from db import get_connection


def load():
    with get_connection() as conn:
        load_payment_methods(conn)
        load_test_addresses(conn)
        load_test_users(conn)
        load_test_stores(conn)
        load_test_store_phones(conn)
        load_test_carts(conn)
        load_test_products(conn)


if __name__ == '__main__':
    print('Executing test dataload script')
    load()
    print('Test dataload finished successfully')
