from psycopg.rows import TupleRow
from dotenv import load_dotenv
from pathlib import Path
import psycopg as pg
import os

load_dotenv()


def get_connection():
    return pg.connect(os.getenv('DB_URL'))


def clear_database(conn: pg.Connection[TupleRow]):
    migrations_dir = Path(__file__).resolve().parent.parent / 'migrations'
    with open(migrations_dir / 'U3__truncate_tables.sql', 'r') as f:
        script = f.read()

    with conn.cursor() as c:
        c.execute(script)

    print('Database cleared')
