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


def load_test_users(conn: Connection[TupleRow]):
    with conn.cursor() as c:
        c.executemany(
            '''
            INSERT INTO "user" (cpf, profile_pic_url, email, username, phone, birthday, password, address_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)''',
            get_data(users, ['cpf', 'profile_pic', 'email', 'username', 'phone', 'birthday', 'password', 'address_id'])
        )

    print('Test users initialized')


def load_test_stores(conn: Connection[TupleRow]):
    with conn.cursor() as c:
        c.executemany(
            '''
            INSERT INTO store (cnpj, name, picture_url, email, password, address_id)
            VALUES (%s, %s, %s, %s, %s, %s)''',
            get_data(stores, ['cnpj', 'name', 'picture_url', 'email', 'password', 'address_id'])
        )

    print('Test stores initialized')


def load_test_store_phones(conn: Connection[TupleRow]):
    with conn.cursor() as c:
        c.execute('SELECT id FROM store')
        store_ids = [row[0] for row in c.fetchall()]

    i = 0
    expanded_store_ids = [*store_ids]
    while len(expanded_store_ids) < len(store_phones):
        expanded_store_ids.append(store_ids[i])
        i = (i + 1) % len(store_ids)

    phones = [(phone, store_id) for phone, store_id in zip(store_phones, expanded_store_ids)]
    with conn.cursor() as c:
        c.executemany('INSERT INTO store_phones (phone, store_id) VALUES (%s, %s)', phones)

    print('Test store phones initialized')


def load_test_carts(conn: Connection[TupleRow]):
    with conn.cursor() as c:
        c.execute('SELECT id FROM "user"')
        user_ids = c.fetchall()

        c.executemany('INSERT INTO cart (user_id) VALUES (%s)', user_ids)

    print('Test carts initialized')


def load_test_products(conn: Connection[TupleRow]):
    with conn.cursor() as c:
        c.execute('SELECT id FROM store')
        store_ids = [row[0] for row in c.fetchall()]

    i = 0
    expanded_store_ids = [*store_ids]
    while len(expanded_store_ids) < len(products):
        expanded_store_ids.append(store_ids[i])
        i = (i + 1) % len(store_ids)

    product_data = get_data(products, ['name', 'price', 'attributes'])
    complete_products = [(*product, store_id) for product, store_id in zip(product_data, expanded_store_ids)]
    with conn.cursor() as c:
        c.executemany(
            '''
            INSERT INTO product (name, price, attributes, store_id)
            VALUES (%s, %s, %s, %s)''',
            complete_products
        )

    print('Test products initialized')
