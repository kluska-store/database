from dotenv import load_dotenv
import psycopg as pg
from psycopg.rows import TupleRow
import os

load_dotenv()


def get_connection():
    return pg.connect(os.getenv('DB_URL'))


def clear_database(conn: pg.Connection[TupleRow]):
    with open('../migrations/U3__truncate_tables.sql', 'r') as f:
        script = f.read()

    with conn.cursor() as c:
        c.execute(script)

    print('Database cleared')
