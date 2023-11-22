# Loading Data
Before we can do any analysis and reporting we need to bring the data into our Snowflake accounts. 

## Load Accounts Data
The first thing we are going to do is load in our accounts data. The bank has 50 Million accounts and these are all spread over multiple CSV files that are held in an external stage. Complete the following steps to load the Accounts data in:

1. Create an internal stage pointing to **s3://snowbank-hackathon/accounts_data/**
2. Create an **ACCOUNTS** table
```
create or replace TABLE ACCOUNTS (
	ACCOUNT_UID STRING,
	DEPOSITOR_ID STRING,
	PRODUCT_CODE INT,
    REGISTERED_PLAN_TYPE_CODE INT,
	REGISTERED_PLAN_NUMBER INT,
	CURRENCY_CODE INT,
	INSURANCE_DETERMINATION_CATEGORY_TYPE_CODE INT,
	ACCOUNT_BALANCE DECIMAL(30,2),
	ACCESSIBLE_BALANCE DECIMAL(30,2),
	CURRENT_CDIC_HOLD_AMOUNT DECIMAL(30,2),
	ACCOUNT_STATUS_CODE INT,
	CDIC_HOLD_STATUS_CODE INT,
	REGISTERED_ACCOUNT_FLAG BOOLEAN
);

```
3. Load the data into the table using Snowflake's COPY INTO command
4. Truncate the table and increase the warehouse size to a large and repeat the loading of data into the ACCOUNTS table. Did you notice any difference in speed?
5. 

Ensure both warehouses are created as small and that the auto-suspend and auto-resume parameters are enabled. We will later grant permissions to different roles to use these warehouses in the setup script.

## Run the setup script
Run the [account setup](account_setup.sql) script to create the relevant roles and permission grants. 

Once complete you are now ready to dive into ingesting some data. 
