ROLLBACK;
BEGIN;

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE "store"
(
    "id"          UUID PRIMARY KEY            DEFAULT gen_random_uuid(),
    "cnpj"        VARCHAR(14) UNIQUE NOT NULL,
    "name"        VARCHAR(50)        NOT NULL,
    "picture_url" VARCHAR(255),
    "email"       VARCHAR(100)       NOT NULL,
    "is_active"   BOOLEAN            NOT NULL DEFAULT FALSE,
    "password"    VARCHAR(100)       NOT NULL,
    "address_id"  INTEGER UNIQUE
);

CREATE TABLE "store_session"
(
    "token"           VARCHAR(36) PRIMARY KEY,
    "expiration_date" TIMESTAMP NOT NULL,
    "store_id"        UUID      NOT NULL
);

CREATE TABLE "store_phones"
(
    "id"       INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "phone"    VARCHAR(15) NOT NULL,
    "store_id" UUID        NOT NULL
);

CREATE TABLE "address"
(
    "id"          INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "country"     VARCHAR(50)  NOT NULL,
    "state"       VARCHAR(50)  NOT NULL,
    "city"        VARCHAR(100) NOT NULL,
    "street"      VARCHAR(100) NOT NULL,
    "number"      INTEGER      NOT NULL CHECK ("number" >= 0),
    "postal_code" VARCHAR(8)   NOT NULL,
    "complement"  VARCHAR(255)
);

CREATE TABLE "user"
(
    "id"              UUID PRIMARY KEY            DEFAULT gen_random_uuid(),
    "cpf"             VARCHAR(11) UNIQUE NOT NULL,
    "profile_pic_url" VARCHAR(255),
    "email"           VARCHAR(50)        NOT NULL,
    "username"        VARCHAR(50)        NOT NULL,
    "phone"           VARCHAR(15)        NOT NULL,
    "birthday"        DATE               NOT NULL CHECK ("birthday" < current_date - interval '16 years'),
    "is_active"       BOOLEAN            NOT NULL DEFAULT FALSE,
    "password"        VARCHAR(100)       NOT NULL,
    "address_id"      INTEGER UNIQUE
);

CREATE TABLE "user_session"
(
    "token"           VARCHAR(36) PRIMARY KEY,
    "expiration_date" TIMESTAMP NOT NULL,
    "user_id"         UUID      NOT NULL
);

CREATE TABLE "product"
(
    "id"         INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"       VARCHAR(100)   NOT NULL,
    "price"      NUMERIC(10, 2) NOT NULL CHECK ("price" > 0),
    "attributes" JSONB,
    "store_id"   UUID           NOT NULL
);

CREATE TABLE "wish_list"
(
    "id"      INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"    VARCHAR(50) NOT NULL,
    "user_id" UUID        NOT NULL
);

CREATE TABLE "wish_list_item"
(
    "id"           INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "wish_list_id" INTEGER NOT NULL,
    "product_id"   INTEGER NOT NULL,
    "amount"       INTEGER NOT NULL DEFAULT 1 CHECK ("amount" > 0)
);

CREATE TABLE "cart"
(
    "id"      INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "user_id" UUID UNIQUE NOT NULL
);

CREATE TABLE "cart_item"
(
    "id"         INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "cart_id"    INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "amount"     INTEGER NOT NULL DEFAULT 1 CHECK ("amount" > 0)
);

/*
Although it's necessary to have a payment method,
it must be nullable to avoid data loss if some payment method is deleted

Same thing about cart: if, somehow, the user is deleted together with its cart,
I cannot lose payment data, so the field must be nullable
*/
CREATE TABLE "payment"
(
    "id"                INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "value"             NUMERIC(10, 2) NOT NULL CHECK ("value" > 0),
    "date"              TIMESTAMP      NOT NULL,
    "payment_method_id" INTEGER,
    "cart_id"           INTEGER
);

CREATE TABLE "payment_method"
(
    "id"     INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "method" VARCHAR(30) UNIQUE NOT NULL
);

/*
Here, in case either the store or the payment is deleted
I cannot lose monetary data
*/
CREATE TABLE "transference"
(
    "id"         INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "store_id"   UUID,
    "payment_id" INTEGER,
    "value"      NUMERIC(10, 2) NOT NULL
);

COMMIT;