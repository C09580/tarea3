--------------------------------------------------------
--  DDL for Table CHANNELS
--------------------------------------------------------

  CREATE TABLE "CHANNELS" 
   (	"CHANNEL_KEY" NUMBER, 
	"CHANNEL_NAME" VARCHAR2(20), 
	"CHANNEL_TYPE" VARCHAR2(30), 
	"CLASS_NAME" VARCHAR2(20)
   ) ;

   COMMENT ON COLUMN "CHANNELS"."CHANNEL_KEY" IS 'Surrogate Key';
   COMMENT ON COLUMN "CHANNELS"."CHANNEL_NAME" IS 'Business name for distribution channel';
   COMMENT ON COLUMN "CHANNELS"."CHANNEL_TYPE" IS 'Type of distribution channel (Mall, Boutique, etc.)';
   COMMENT ON COLUMN "CHANNELS"."CLASS_NAME" IS 'Business name';
--------------------------------------------------------
--  DDL for Table CUSTOMERS
--------------------------------------------------------

  CREATE TABLE "CUSTOMERS" 
   (	"CUSTOMER_KEY" NUMBER, 
	"CUSTOMER_NUMBER" NUMBER, 
	"AGE" NUMBER, 
	"AGE_RANGE" VARCHAR2(30), 
	"FIRST_NAME" VARCHAR2(200), 
	"GENDER" VARCHAR2(6), 
	"INCOME" NUMBER, 
	"LAST_NAME" VARCHAR2(200), 
	"STREET_ADDRESS" VARCHAR2(400), 
	"CITY_NAME" VARCHAR2(100), 
	"STATE_PROVINCE_NAME" VARCHAR2(400), 
	"COUNTRY_NAME" VARCHAR2(100), 
	"REGION_NAME" VARCHAR2(100)
   ) ;
--------------------------------------------------------
--  DDL for Table PRODUCTS
--------------------------------------------------------

  CREATE TABLE "PRODUCTS" 
   (	"CATEGORY_NAME" VARCHAR2(100), 
	"CATEGORY_MANAGER" VARCHAR2(100), 
	"TYPE_NAME" VARCHAR2(100), 
	"SUBTYPE_NAME" VARCHAR2(100), 
	"ITEM_KEY" NUMBER, 
	"ITEM_NAME" VARCHAR2(100), 
	"VENDOR_NAME" VARCHAR2(100)
   ) ;

   COMMENT ON COLUMN "PRODUCTS"."CATEGORY_NAME" IS 'Business Key';
   COMMENT ON COLUMN "PRODUCTS"."CATEGORY_MANAGER" IS 'Category Manager';
   COMMENT ON COLUMN "PRODUCTS"."TYPE_NAME" IS 'Business Key';
   COMMENT ON COLUMN "PRODUCTS"."SUBTYPE_NAME" IS 'Long Description';
   COMMENT ON COLUMN "PRODUCTS"."ITEM_KEY" IS 'Surrogate Key';
   COMMENT ON COLUMN "PRODUCTS"."ITEM_NAME" IS 'Business Key';
   COMMENT ON COLUMN "PRODUCTS"."VENDOR_NAME" IS 'Business key';
--------------------------------------------------------
--  DDL for Table SALES_FACT
--------------------------------------------------------

  CREATE TABLE "SALES_FACT" 
   (	"QUANTITY" NUMBER(10,2), 
	"PRICE" NUMBER(10,2), 
	"SALES" NUMBER(10,2), 
	"DAY_KEY" DATE, 
	"PRODUCT" NUMBER, 
	"CHANNEL" NUMBER, 
	"CUSTOMER" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table TIMES
--------------------------------------------------------

  CREATE TABLE "TIMES" 
   (	"DAY_KEY" DATE, 
	"CALENDAR_YEAR_NAME" VARCHAR2(40), 
	"CALENDAR_QUARTER_NAME" VARCHAR2(40), 
	"MONTH_NAME" VARCHAR2(40), 
	"MONTH_NUMBER_IN_YEAR" NUMBER, 
	"NUMBER_IN_WEEK" NUMBER, 
	"NUMBER_IN_MONTH" NUMBER, 
	"DAY_DESCRIPTION" VARCHAR2(40)
   ) ;

--------------------------------------------------------
--  DDL for Index SALES_CUST_BIDX
--------------------------------------------------------

  CREATE BITMAP INDEX "SALES_CUST_BIDX" ON "SALES_FACT" ("CUSTOMER") 
  ;
--------------------------------------------------------
--  DDL for Index SALES_PROD_BIDX
--------------------------------------------------------

  CREATE BITMAP INDEX "SALES_PROD_BIDX" ON "SALES_FACT" ("PRODUCT") 
  ;
--------------------------------------------------------
--  DDL for Index SALES_TIME_BIDX
--------------------------------------------------------

  CREATE BITMAP INDEX "SALES_TIME_BIDX" ON "SALES_FACT" ("DAY_KEY") 
  ;
--------------------------------------------------------
--  DDL for Index SALES_CHANNEL_BIDX
--------------------------------------------------------

  CREATE BITMAP INDEX "SALES_CHANNEL_BIDX" ON "SALES_FACT" ("CHANNEL") 
  ;
--------------------------------------------------------
--  Constraints for Table CHANNELS
--------------------------------------------------------

  ALTER TABLE "CHANNELS" MODIFY ("CHANNEL_KEY" CONSTRAINT "COAD_NN000181" NOT NULL ENABLE);
  ALTER TABLE "CHANNELS" ADD CONSTRAINT "CHANNELS_PK" PRIMARY KEY ("CHANNEL_KEY")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table CUSTOMERS
--------------------------------------------------------

  ALTER TABLE "CUSTOMERS" ADD CONSTRAINT "CUSTOMERS_PK" PRIMARY KEY ("CUSTOMER_KEY")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table PRODUCTS
--------------------------------------------------------

  ALTER TABLE "PRODUCTS" MODIFY ("ITEM_KEY" CONSTRAINT "COAD_NN000189" NOT NULL ENABLE);
  ALTER TABLE "PRODUCTS" ADD CONSTRAINT "PRODUCTS_PK" PRIMARY KEY ("ITEM_KEY")
  USING INDEX  ENABLE;

--------------------------------------------------------
--  Constraints for Table TIMES
--------------------------------------------------------

  ALTER TABLE "TIMES" MODIFY ("DAY_KEY" NOT NULL ENABLE);
  ALTER TABLE "TIMES" ADD CONSTRAINT "TIMES_DIMENSION_KEY_PK" PRIMARY KEY ("DAY_KEY")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SALES_FACT
--------------------------------------------------------

  ALTER TABLE "SALES_FACT" ADD CONSTRAINT "SALES_FACT_CHAN_FK" FOREIGN KEY ("CHANNEL")
	  REFERENCES "CHANNELS" ("CHANNEL_KEY") ENABLE;
  ALTER TABLE "SALES_FACT" ADD CONSTRAINT "SALES_FACT_PROD_FK" FOREIGN KEY ("PRODUCT")
	  REFERENCES "PRODUCTS" ("ITEM_KEY") ENABLE;
  ALTER TABLE "SALES_FACT" ADD CONSTRAINT "SALES_FACT_CUST_FK" FOREIGN KEY ("CUSTOMER")
	  REFERENCES "CUSTOMERS" ("CUSTOMER_KEY") ENABLE;
  ALTER TABLE "SALES_FACT" ADD CONSTRAINT "SALES_TIME_FK" FOREIGN KEY ("DAY_KEY")
	  REFERENCES "TIMES" ("DAY_KEY") ENABLE;
