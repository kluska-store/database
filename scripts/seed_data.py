from psycopg import Connection
from psycopg.rows import TupleRow
from argon2 import PasswordHasher


def load_payment_methods(conn: Connection[TupleRow]):
  payment_methods = [('Crédito',), ('Débito',), ('Pix',)]

  with conn.cursor() as c:
    c.executemany('INSERT INTO payment_method(method) VALUES (%s)', payment_methods)
    print('Payment methods initialized')


def load_initial_users(conn: Connection[TupleRow]):
  ph = PasswordHasher()

  initial_users = [
      (
          '19178191700',
          None,
          'lkd.lucas@gmail.com',
          'Lucas Kluska Donini',
          '5511969130303',
          '2010-03-03',
          True,
          ph.hash('12345678'),
          None
      )
  ]

  with conn.cursor() as c:
    sql = '''
          INSERT INTO "user"(
            "cpf", 
            "profile_pic_url", 
            "email", 
            "username", 
            "phone", 
            "birthday", 
            "is_active", 
            "password", 
            "address_id"
          ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
          '''

    c.executemany(sql, initial_users)
    print('Default users initialized')
