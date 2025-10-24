BEGIN;

ALTER TABLE "store"
    DROP CONSTRAINT IF EXISTS "fk_store_address_id__address_id";

ALTER TABLE "store_phones"
    DROP CONSTRAINT IF EXISTS "fk_store_phones_store_id__store_id";

ALTER TABLE "user"
    DROP CONSTRAINT IF EXISTS "fk_user_address_id__address_id";

ALTER TABLE "session"
    DROP CONSTRAINT IF EXISTS "fk_session_user_id__user_id";

ALTER TABLE "product"
    DROP CONSTRAINT IF EXISTS "fk_product_store_id__store_id",
    DROP CONSTRAINT IF EXISTS "unique_product_per_store";

ALTER TABLE "wish_list"
    DROP CONSTRAINT IF EXISTS "fk_wish_list_user_id__user_id",
    DROP CONSTRAINT IF EXISTS "unique_wish_list_per_user";

ALTER TABLE "wish_list_item"
    DROP CONSTRAINT IF EXISTS "fk_wish_list_item_wish_list_id__wish_list_id",
    DROP CONSTRAINT IF EXISTS "fk_wish_list_item_product_id__product_id";

ALTER TABLE "cart"
    DROP CONSTRAINT IF EXISTS "fk_cart_user_id__user_id";

ALTER TABLE "cart_item"
    DROP CONSTRAINT IF EXISTS "fk_cart_item_cart_id__cart_id",
    DROP CONSTRAINT IF EXISTS "fk_cart_item_product_id__product_id";

ALTER TABLE "payment"
    DROP CONSTRAINT IF EXISTS "fk_payment_payment_method_id__payment_method_id",
    DROP CONSTRAINT IF EXISTS "fk_payment_user_id__user_id";

ALTER TABLE "transference"
    DROP CONSTRAINT IF EXISTS "fk_transference_store_id__store_id",
    DROP CONSTRAINT IF EXISTS "fk_transference_payment_id__payment_id";

DROP INDEX IF EXISTS
    "idx_unique_active_store_cnpj",
    "idx_unique_active_store_address",
    "idx_unique_active_user_email",
    "idx_unique_active_user_cpf",
    "idx_unique_active_user_phone";

COMMIT;
ROLLBACK;