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
    "number"      INTEGER      NOT NULL,
    "postal_code" VARCHAR(10)  NOT NULL,
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
    "birthday"        DATE               NOT NULL,
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
    "price"      NUMERIC(10, 2) NOT NULL,
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
    "product_id"   INTEGER NOT NULL
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
    "product_id" INTEGER NOT NULL
);

CREATE TABLE "payment"
(
    "id"                INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "value"             NUMERIC(10, 2) NOT NULL,
    "date"              TIMESTAMP      NOT NULL,
    "payment_method_id" INTEGER,
    "user_id"           UUID
);

CREATE TABLE "payment_method"
(
    "id"     INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "method" VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE "transference"
(
    "id"         INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "store_id"   UUID,
    "payment_id" INTEGER,
    "value"      NUMERIC(10, 2) NOT NULL
);

COMMIT;