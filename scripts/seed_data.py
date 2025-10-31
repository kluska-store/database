from psycopg import Connection
from psycopg.rows import TupleRow


def load_payment_methods(conn: Connection[TupleRow]):
    payment_methods = [('Crédito',), ('Débito',), ('Pix',)]

    with conn.cursor() as c:
        c.executemany('INSERT INTO payment_method(method) VALUES (%s)', payment_methods)
        print('Payment methods initialized')
