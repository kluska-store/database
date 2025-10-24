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
