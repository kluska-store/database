from db import get_connection, clear_database
from seed_data import load_payment_methods


def load():
    with get_connection() as conn:
        clear_database(conn)
        load_payment_methods(conn)


if __name__ == '__main__':
    print('Executing dataload script')
    load()
    print('Dataload finished successfully')
