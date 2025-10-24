BEGIN;

ALTER TABLE "store"
    DROP CONSTRAINT "fk_store_address_id__address_id";

ALTER TABLE "store_phones"
    DROP CONSTRAINT "fk_store_phones_store_id__store_id";

ALTER TABLE "user"
    DROP CONSTRAINT "fk_user_address_id__address_id";

ALTER TABLE "session"
    DROP CONSTRAINT "fk_session_user_id__user_id";

ALTER TABLE "product"
    DROP CONSTRAINT "fk_product_store_id__store_id",
    DROP CONSTRAINT "unique_product_per_store";

ALTER TABLE "wish_list"
    DROP CONSTRAINT "fk_wish_list_user_id__user_id",
    DROP CONSTRAINT "unique_wish_list_per_user";

ALTER TABLE "wish_list_item"
    DROP CONSTRAINT "fk_wish_list_item_wish_list_id__wish_list_id",
    DROP CONSTRAINT "fk_wish_list_item_product_id__product_id";

ALTER TABLE "cart"
    DROP CONSTRAINT "fk_cart_user_id__user_id";

ALTER TABLE "cart_item"
    DROP CONSTRAINT "fk_cart_item_cart_id__cart_id",
    DROP CONSTRAINT "fk_cart_item_product_id__product_id";

ALTER TABLE "payment"
    DROP CONSTRAINT "fk_payment_payment_method_id__payment_method_id",
    DROP CONSTRAINT "fk_payment_user_id__user_id";

ALTER TABLE "transference"
    DROP CONSTRAINT "fk_transference_store_id__store_id",
    DROP CONSTRAINT "fk_transference_payment_id__payment_id";

DROP INDEX
    "idx_unique_active_store_cnpj",
    "idx_unique_active_store_address",
    "idx_unique_active_user_email",
    "idx_unique_active_user_cpf",
    "idx_unique_active_user_phone";

COMMIT;
ROLLBACK;