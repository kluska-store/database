import psycopg as pg
from dotenv import load_dotenv
import os

load_dotenv()


def get_connection():
    return pg.connect(os.getenv('DB_URL'))
