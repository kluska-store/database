from dateutil.relativedelta import relativedelta
from argon2 import PasswordHasher
from datetime import datetime
from faker import Faker
import pandas as pd
import random as rd
import re

SEED = 29
Faker.seed(SEED)
rd.seed(SEED)

ph = PasswordHasher()
fk = Faker('pt-BR')
QNT = 10


def generate_addresses(qnt=2 * QNT - 1):
    complements = ['Casa 2', 'Apto. 162', 'Casa B', 'Galpão A', None, None, None, None, None, None]
    raw_addresses = []

    for ad in [fk.address() for _ in range(qnt)]:
        split_ad = ad.split('\n')
        street_address = split_ad[0].split(',')
        street = street_address[0]
        number = int(street_address[1]) if len(street_address) > 1 else 0
        temp, state = split_ad[2].split('/')
        postal_code, city = temp.split(' ', maxsplit=1)
        postal_code = postal_code.replace('-', '')
        complement = rd.choice(complements)

        raw_addresses.append(('Brasil', state, city, street, number, postal_code, complement))

    return raw_addresses


def id_generator(df: pd.DataFrame):
    next_id = 0
    while True:
        next_id = (next_id + 1) % (len(df) + 1)
        if next_id == 0: continue
        yield next_id


def get_data(df: pd.DataFrame, cols: list[str]):
    return df[cols].itertuples(index=False, name=None)


addresses = pd.DataFrame(
    data=generate_addresses(),
    columns=['country', 'state', 'city', 'street', 'number', 'postal_code', 'complement']
)

seq_address_id = id_generator(addresses)

gen_date = lambda: fk.date_between(datetime.now() - relativedelta(years=50), datetime.now() - relativedelta(years=12))
gen_password = lambda size: fk.password(length=size)

users = pd.DataFrame({
    'cpf': [fk.cpf() for _ in range(QNT)],
    'profile_pic': [None] * QNT,
    'email': [fk.email() for _ in range(QNT)],
    'username': [fk.name() for _ in range(QNT)],
    'phone': [fk.cellphone_number() for _ in range(QNT)],
    'birthday': [gen_date() for _ in range(QNT)],
    'is_active': [True] * QNT,
    'raw_password': [gen_password(8) for _ in range(QNT)],
    'address_id': [next(seq_address_id) for _ in range(QNT)],
})

users['password'] = users['raw_password'].apply(ph.hash)
users['phone'] = users['phone'].apply(lambda x: re.sub(r'[^0-9]', '', x))
users.to_csv('csv/test_logins.csv', columns=['email', 'raw_password'])
users.drop(columns=['raw_password'], inplace=True)

stores = pd.DataFrame({
    'cnpj': [fk.cnpj() for _ in range(QNT)],
    'name': [fk.company() for _ in range(QNT)],
    'picture_url': [None] * QNT,
    'email': [fk.company_email() for _ in range(QNT)],
    'is_active': [True] * QNT,
    'raw_password': [gen_password(8) for _ in range(QNT)],
    'address_id': [next(seq_address_id) for _ in range(QNT)]
})

stores['password'] = stores['raw_password'].apply(ph.hash)
stores.to_csv('csv/test_store_logins.csv', columns=['email', 'raw_password'])
stores.drop(columns=['raw_password'], inplace=True)

seq_store_id = id_generator(stores)

store_phones = pd.DataFrame({
    'phone': [fk.cellphone_number() for _ in range(QNT + QNT // 5)],
    'store_id': [next(seq_store_id) for _ in range(QNT + QNT // 5)]
})

store_phones['phone'] = store_phones['phone'].apply(lambda x: re.sub(r'[^0-9+]', '', x))

products = pd.DataFrame({
    'name': [f'{fk.word().capitalize()} {fk.word()}' for _ in range(QNT * 10)],
    'price': [round(rd.uniform(10, 100), 2) for _ in range(QNT * 10)],
    'attributes': [None] * QNT * 10,
    'store_id': [next(seq_store_id) for _ in range(QNT * 10)]
})

carts = pd.DataFrame({
    'user_id': [i + 1 for i in range(len(users))]
})
