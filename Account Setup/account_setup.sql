USE ROLE ACCOUNTADMIN;

CREATE ROLE IF NOT EXISTS BANK_ENGINEER_ROLE;
CREATE ROLE IF NOT EXISTS BANK_ANALYST_ROLE;
CREATE ROLE IF NOT EXISTS BANK_DEV_ROLE;

GRANT import share on account to role BANK_ENGINEER_ROLE;
GRANT create share on account to role BANK_ENGINEER_ROLE;
grant create integration on account to role BANK_ENGINEER_ROLE;

-- create databases for Snowbank Retail Banking
CREATE OR REPLACE DATABASE SNOWBANK COMMENT = 'Snowbank SNOWBANK Database';

--Create the different data zones for each database.  raw, harmonized, analytics
CREATE OR REPLACE SCHEMA SNOWBANK.raw COMMENT='schema to store raw data from source system';
CREATE OR REPLACE SCHEMA SNOWBANK.analytics COMMENT='schema to store views for analytics / presentation layers';

-- Role Hiearchy
GRANT ROLE BANK_DEV_ROLE TO ROLE BANK_ENGINEER_ROLE;
GRANT ROLE BANK_ENGINEER_ROLE TO ROLE SYSADMIN;
GRANT ROLE BANK_DEV_ROLE TO ROLE SYSADMIN;
GRANT ROLE BANK_ANALYST_ROLE TO ROLE SYSADMIN;

grant create warehouse on account to role BANK_ENGINEER_ROLE;
grant create database on account to role BANK_ENGINEER_ROLE;
grant monitor usage on account to role BANK_ENGINEER_ROLE;
grant create share on account to role BANK_ENGINEER_ROLE;
grant import share on account to role BANK_ENGINEER_ROLE;
grant create integration on account to role BANK_ENGINEER_ROLE;
grant execute task on account to role BANK_ENGINEER_ROLE;
grant manage grants on account to role BANK_ENGINEER_ROLE;


GRANT USAGE ON DATABASE SNOWBANK TO ROLE BANK_ENGINEER_ROLE;
GRANT USAGE ON DATABASE SNOWBANK TO ROLE BANK_ANALYST_ROLE;


GRANT USAGE ON ALL SCHEMAS IN DATABASE SNOWBANK TO ROLE BANK_ENGINEER_ROLE;
GRANT USAGE ON ALL SCHEMAS IN DATABASE SNOWBANK TO ROLE BANK_ANALYST_ROLE;

GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA SNOWBANK.raw TO ROLE BANK_ENGINEER_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA SNOWBANK.analytics TO ROLE BANK_ENGINEER_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA SNOWBANK.analytics TO ROLE BANK_ANALYST_ROLE;

GRANT SELECT ON ALL VIEWS IN SCHEMA SNOWBANK.raw TO ROLE BANK_ENGINEER_ROLE;
GRANT SELECT ON ALL VIEWS IN SCHEMA SNOWBANK.analytics TO ROLE BANK_ENGINEER_ROLE;
GRANT SELECT ON ALL VIEWS IN SCHEMA SNOWBANK.analytics TO ROLE BANK_ANALYST_ROLE;

--Future

GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON FUTURE TABLES IN SCHEMA SNOWBANK.raw TO ROLE BANK_ENGINEER_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON FUTURE TABLES IN SCHEMA SNOWBANK.analytics TO ROLE BANK_ENGINEER_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON FUTURE TABLES IN SCHEMA SNOWBANK.analytics TO ROLE BANK_ANALYST_ROLE;

GRANT SELECT ON FUTURE VIEWS IN SCHEMA SNOWBANK.raw TO ROLE BANK_ENGINEER_ROLE;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA SNOWBANK.analytics TO ROLE BANK_ENGINEER_ROLE;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA SNOWBANK.analytics TO ROLE BANK_ANALYST_ROLE;

GRANT MODIFY, MONITOR, USAGE ON WAREHOUSE SNOWBANK_LOAD_WH TO ROLE BANK_ENGINEER_ROLE;
GRANT MODIFY, MONITOR, USAGE ON WAREHOUSE SNOWBANK_ANALYTICS_WH TO ROLE BANK_ENGINEER_ROLE;
GRANT MODIFY, MONITOR, USAGE ON WAREHOUSE SNOWBANK_ANALYTICS_WH TO ROLE BANK_ANALYST_ROLE;

--Create Objects
GRANT CREATE VIEW ON SCHEMA SNOWBANK.raw to BANK_ENGINEER_ROLE;
GRANT CREATE VIEW ON SCHEMA SNOWBANK.analytics to BANK_ENGINEER_ROLE;
GRANT CREATE VIEW ON SCHEMA SNOWBANK.analytics to BANK_ANALYST_ROLE;

GRANT CREATE TABLE ON SCHEMA SNOWBANK.raw to BANK_ENGINEER_ROLE;
GRANT CREATE TABLE ON SCHEMA SNOWBANK.analytics to BANK_ENGINEER_ROLE;

GRANT CREATE STAGE ON SCHEMA SNOWBANK.raw to BANK_ENGINEER_ROLE;

GRANT CREATE MASKING POLICY ON SCHEMA SNOWBANK.analytics TO ROLE BANK_ENGINEER_ROLE;
GRANT APPLY MASKING POLICY ON ACCOUNT TO ROLE BANK_ENGINEER_ROLE;
GRANT CREATE MASKING POLICY ON SCHEMA SNOWBANK.analytics TO ROLE BANK_ANALYST_ROLE;
GRANT APPLY MASKING POLICY ON ACCOUNT TO ROLE BANK_ANALYST_ROLE;

GRANT CREATE STREAMLIT ON SCHEMA SNOWBANK.analytics TO ROLE BANK_ENGINEER_ROLE;
GRANT CREATE STREAMLIT ON SCHEMA SNOWBANK.analytics TO ROLE BANK_ANALYST_ROLE;