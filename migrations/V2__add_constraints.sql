ROLLBACK;
BEGIN;

-- FOREIGN KEYS
ALTER TABLE "store" ADD CONSTRAINT "fk_store_address_id__address_id"
    FOREIGN KEY ("address_id") REFERENCES "address" ("id")
    ON DELETE SET NULL;

ALTER TABLE "store_session" ADD CONSTRAINT "fk_store_session_store_id__store_id"
    FOREIGN KEY ("store_id") REFERENCES "store" ("id")
    ON DELETE CASCADE;

ALTER TABLE "store_phones" ADD CONSTRAINT "fk_store_phones_store_id__store_id"
    FOREIGN KEY ("store_id") REFERENCES "store" ("id")
    ON DELETE CASCADE;

ALTER TABLE "user" ADD CONSTRAINT "fk_user_address_id__address_id"
    FOREIGN KEY ("address_id") REFERENCES "address" ("id")
    ON DELETE SET NULL;

ALTER TABLE "user_session" ADD CONSTRAINT "fk_user_session_user_id__user_id"
    FOREIGN KEY ("user_id") REFERENCES "user" ("id")
    ON DELETE CASCADE;

ALTER TABLE "product" ADD CONSTRAINT "fk_product_store_id__store_id"
    FOREIGN KEY ("store_id") REFERENCES "store" ("id")
    ON DELETE CASCADE;

ALTER TABLE "wish_list" ADD CONSTRAINT "fk_wish_list_user_id__user_id"
    FOREIGN KEY ("user_id") REFERENCES "user" ("id")
    ON DELETE CASCADE;

ALTER TABLE "cart" ADD CONSTRAINT "fk_cart_user_id__user_id"
    FOREIGN KEY ("user_id") REFERENCES "user" ("id")
    ON DELETE CASCADE;

ALTER TABLE "wish_list_item"
    ADD CONSTRAINT "fk_wish_list_item_wish_list_id__wish_list_id"
        FOREIGN KEY ("wish_list_id") REFERENCES "wish_list" ("id")
        ON DELETE CASCADE,
    ADD CONSTRAINT "fk_wish_list_item_product_id__product_id"
        FOREIGN KEY ("product_id") REFERENCES "product" ("id")
        ON DELETE CASCADE;

ALTER TABLE "cart_item"
    ADD CONSTRAINT "fk_cart_item_cart_id__cart_id"
        FOREIGN KEY ("cart_id") REFERENCES "cart" ("id")
        ON DELETE CASCADE,
    ADD CONSTRAINT "fk_cart_item_product_id__product_id"
        FOREIGN KEY ("product_id") REFERENCES "product" ("id")
        ON DELETE CASCADE;

ALTER TABLE "payment"
    ADD CONSTRAINT "fk_payment_payment_method_id__payment_method_id"
        FOREIGN KEY ("payment_method_id") REFERENCES "payment_method" ("id")
        ON DELETE SET NULL,
    ADD CONSTRAINT "fk_payment_user_id__user_id"
        FOREIGN KEY ("user_id") REFERENCES "user" ("id")
        ON DELETE SET NULL;

ALTER TABLE "transference"
    ADD CONSTRAINT "fk_transference_store_id__store_id"
        FOREIGN KEY ("store_id") REFERENCES "store" ("id")
        ON DELETE SET NULL,
    ADD CONSTRAINT "fk_transference_payment_id__payment_id"
        FOREIGN KEY ("payment_id") REFERENCES "payment" ("id")
        ON DELETE SET NULL;


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