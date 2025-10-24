BEGIN;

-- FOREIGN KEYS
ALTER TABLE "store" ADD FOREIGN KEY ("address_id") REFERENCES "address" ("id");

ALTER TABLE "store_phones" ADD FOREIGN KEY ("store_id") REFERENCES "store" ("id");

ALTER TABLE "user" ADD FOREIGN KEY ("address_id") REFERENCES "address" ("id");

ALTER TABLE "session" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "product" ADD FOREIGN KEY ("store_id") REFERENCES "store" ("id");

ALTER TABLE "wish_list" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "cart" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "wish_list_item"
    ADD FOREIGN KEY ("wish_list_id") REFERENCES "wish_list" ("id"),
    ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

ALTER TABLE "cart_item"
    ADD FOREIGN KEY ("cart_it") REFERENCES "cart" ("id"),
    ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

ALTER TABLE "payment"
    ADD FOREIGN KEY ("payment_method_id") REFERENCES "payment_method" ("id"),
    ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "transference"
    ADD FOREIGN KEY ("store_id") REFERENCES "store" ("id"),
    ADD FOREIGN KEY ("payment_id") REFERENCES "payment" ("id");


-- COMPLEX UNIQUE CONSTRAINTS
CREATE UNIQUE INDEX "idx_unique_active_store_cnpj"
    ON "store" ("cnpj") WHERE ("is_active");

CREATE UNIQUE INDEX "idx_unique_active_store_address"
    ON "store" ("address_id") WHERE ("is_active");

CREATE UNIQUE INDEX "idx_unique_active_user_cpf"
    ON "user" ("cpf") WHERE ("is_active");

CREATE UNIQUE INDEX "idx_unique_active_user_email"
    ON "user" ("email") WHERE ("is_active");

CREATE UNIQUE INDEX "idx_unique_active_user_phone"
    ON "user" ("phone") WHERE ("is_active");

ALTER TABLE "wish_list"
    ADD CONSTRAINT "unique_wish_list_per_user" UNIQUE ("name", "user_id");

ALTER TABLE "product"
    ADD CONSTRAINT "unique_product_per_store" UNIQUE ("name", "store_id");

COMMIT;
-- ROLLBACK;