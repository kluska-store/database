from db import get_connection
from seed_data import *


def load():
  with get_connection() as conn:
    load_initial_users(conn)
    load_payment_methods(conn)


if __name__ == '__main__':
  print('Executing dataload script')
  load()
  print('Dataload finished successfully')