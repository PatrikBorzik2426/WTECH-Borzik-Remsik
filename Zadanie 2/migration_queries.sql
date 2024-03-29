
   INFO  Running migrations.  

-- 2019_12_14_000001_create_personal_access_tokens_table
CREATE TABLE "personal_access_tokens" (
    "id" bigserial NOT NULL PRIMARY KEY,
    "tokenable_type" varchar(255) NOT NULL,
    "tokenable_id" bigint NOT NULL,
    "name" varchar(255) NOT NULL,
    "token" varchar(64) NOT NULL,
    "abilities" text NULL,
    "last_used_at" timestamp(0) WITHOUT TIME ZONE NULL,
    "expires_at" timestamp(0) WITHOUT TIME ZONE NULL,
    "created_at" timestamp(0) WITHOUT TIME ZONE NULL,
    "updated_at" timestamp(0) WITHOUT TIME ZONE NULL
);
CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" ON "personal_access_tokens" ("tokenable_type", "tokenable_id");
ALTER TABLE "personal_access_tokens" ADD CONSTRAINT "personal_access_tokens_token_unique" UNIQUE ("token");

-- 2024_02_18_080949_create_users_table
CREATE TABLE "users" (
    "id" serial NOT NULL PRIMARY KEY,
    "login" varchar(255) NOT NULL,
    "password" varchar(255) NOT NULL,
    "name" varchar(255) NOT NULL,
    "surname" varchar(255) NOT NULL,
    "email" varchar(255) NOT NULL,
    "address" varchar(255) NOT NULL,
    "phone_number" varchar(255) NULL,
    "created_at" timestamp(0) WITHOUT TIME ZONE NOT NULL,
    "admin" boolean NOT NULL DEFAULT '0'
);
ALTER TABLE "users" ADD CONSTRAINT "users_login_unique" UNIQUE ("login");
ALTER TABLE "users" ADD CONSTRAINT "users_email_unique" UNIQUE ("email");
ALTER TABLE "users" ADD CONSTRAINT "users_phone_number_unique" UNIQUE ("phone_number");

-- 2024_02_18_081029_create_shopping_sessions_table
CREATE TABLE "shopping_sessions" (
    "id" serial NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "total" double precision NOT NULL,
    "created_at" timestamp(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE "shopping_sessions" ADD CONSTRAINT "shopping_sessions_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;

-- 2024_02_18_081035_create_products_table
CREATE TABLE "products" (
    "id" serial NOT NULL PRIMARY KEY,
    "name" varchar(255) NOT NULL,
    "description" varchar(255) NOT NULL,
    "category" integer NOT NULL,
    "price" double precision NOT NULL,
    "quantity" integer NOT NULL,
    "image" varchar(255) NOT NULL,
    "created_at" timestamp(0) WITHOUT TIME ZONE NOT NULL
);

-- 2024_02_18_081036_create_cart_items_table
CREATE TABLE "cart_items" (
    "id" serial NOT NULL PRIMARY KEY,
    "session_id" integer NOT NULL,
    "product_id" integer NOT NULL,
    "quantity" integer NOT NULL,
    "created_at" timestamp(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "products" ("id") ON DELETE CASCADE;
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_session_id_foreign" FOREIGN KEY ("session_id") REFERENCES "shopping_sessions" ("id") ON DELETE CASCADE;

-- 2024_02_18_081052_create_orders_table
CREATE TABLE "orders" (
    "id" serial NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "shopping_session_id" integer NOT NULL,
    "status" integer NOT NULL DEFAULT '0',
    "created_at" timestamp(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE "orders" ADD CONSTRAINT "orders_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;
ALTER TABLE "orders" ADD CONSTRAINT "orders_shopping_session_id_foreign" FOREIGN KEY ("shopping_session_id") REFERENCES "shopping_sessions" ("id") ON DELETE CASCADE;

-- 2024_02_18_085802_create_parameters_table
CREATE TABLE "parameters" (
    "id" serial NOT NULL PRIMARY KEY,
    "product_id" integer NOT NULL,
    "parameter" varchar(255) NOT NULL,
    "value" varchar(255) NOT NULL
);
ALTER TABLE "parameters" ADD CONSTRAINT "parameters_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "products" ("id") ON DELETE CASCADE;
