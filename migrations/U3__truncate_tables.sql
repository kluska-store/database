ROLLBACK;
BEGIN;

TRUNCATE TABLE
    "address",
    "cart",
    "cart_item",
    "payment",
    "payment_method",
    "product",
    "store",
    "store_phones",
    "store_session",
    "transference",
    "user",
    "user_session",
    "wish_list",
    "wish_list_item"
    CASCADE;

COMMIT;