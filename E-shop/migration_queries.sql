
   INFO  Running migrations.  

  2019_12_14_000001_create_personal_access_tokens_table ............................................................................................  
  Γçé create table "personal_access_tokens" ("id" bigserial not null primary key, "tokenable_type" varchar(255) not null, "tokenable_id" bigint not null, "name" varchar(255) not null, "token" varchar(64) not null, "abilities" text null, "last_used_at" timestamp(0) without time zone null, "expires_at" timestamp(0) without time zone null, "created_at" timestamp(0) without time zone null, "updated_at" timestamp(0) without time zone null)  
  Γçé create index "personal_access_tokens_tokenable_type_tokenable_id_index" on "personal_access_tokens" ("tokenable_type", "tokenable_id")  
  Γçé alter table "personal_access_tokens" add constraint "personal_access_tokens_token_unique" unique ("token")  
  2024_02_18_080949_create_users_table .............................................................................................................  
  Γçé create table "users" ("id" serial not null primary key, "login" varchar(255) not null, "password" varchar(255) not null, "name" varchar(255) not null, "surname" varchar(255) not null, "email" varchar(255) not null, "address" varchar(255) not null, "phone_number" varchar(255) null, "created_at" timestamp(0) without time zone not null, "admin" boolean not null default '0')  
  Γçé alter table "users" add constraint "users_login_unique" unique ("login")  
  Γçé alter table "users" add constraint "users_email_unique" unique ("email")  
  Γçé alter table "users" add constraint "users_phone_number_unique" unique ("phone_number")  
  2024_02_18_081029_create_shopping_sessions_table .................................................................................................  
  Γçé create table "shopping_sessions" ("id" serial not null primary key, "user_id" integer not null, "total" double precision not null, "created_at" timestamp(0) without time zone not null)  
  Γçé alter table "shopping_sessions" add constraint "shopping_sessions_user_id_foreign" foreign key ("user_id") references "users" ("id") on delete cascade  
  2024_02_18_081035_create_products_table ..........................................................................................................  
  Γçé create table "products" ("id" serial not null primary key, "name" varchar(255) not null, "description" varchar(255) not null, "category" integer not null, "price" double precision not null, "quantity" integer not null, "image" varchar(255) not null, "created_at" timestamp(0) without time zone not null)  
  2024_02_18_081036_create_cart_items_table ........................................................................................................  
  Γçé create table "cart_items" ("id" serial not null primary key, "session_id" integer not null, "product_id" integer not null, "quantity" integer not null, "created_at" timestamp(0) without time zone not null)  
  Γçé alter table "cart_items" add constraint "cart_items_product_id_foreign" foreign key ("product_id") references "products" ("id") on delete cascade  
  Γçé alter table "cart_items" add constraint "cart_items_session_id_foreign" foreign key ("session_id") references "shopping_sessions" ("id") on delete cascade  
  2024_02_18_081052_create_orders_table ............................................................................................................  
  Γçé create table "orders" ("id" serial not null primary key, "user_id" integer not null, "shopping_session_id" integer not null, "status" integer not null default '0', "created_at" timestamp(0) without time zone not null)  
  Γçé alter table "orders" add constraint "orders_user_id_foreign" foreign key ("user_id") references "users" ("id") on delete cascade  
  Γçé alter table "orders" add constraint "orders_shopping_session_id_foreign" foreign key ("shopping_session_id") references "shopping_sessions" ("id") on delete cascade  
  2024_02_18_085802_create_parameters_table ........................................................................................................  
  Γçé create table "parameters" ("id" serial not null primary key, "product_id" integer not null, "parameter" varchar(255) not null, "value" varchar(255) not null)  
  Γçé alter table "parameters" add constraint "parameters_product_id_foreign" foreign key ("product_id") references "products" ("id") on delete cascade  

