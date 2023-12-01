# Dynamic DevOps
In this scenario we need to give our Dev access to the ```ACCOUNTS``` data to add a new column, however we don't want them to directly work on the data unmasked in the PROD environment. We need to make a dedicated DEV environment. We also set up data masking to show how we can give data to our developers without letting them see PII.

In this scenario, CDIC Reporting just changed their requirement on the data file to be provided and added an additional column account_type_code.

## Create a DEV environment
The first thing we are going to do is ensure the right guard rails and masking policies are created before we can dynamically provision and deprovision a DEV environment. Go ahead and do the following:
1. Using the ```BANK_ENGINEER_ROLE``` and ```ANALYTICS``` schema create two masking policies. One for strings and one for integers. Make sure only ```BANK_ENGINEER_ROLE``` and ```BANK_ANALYST_ROLE``` have access to the unmasked data.
2. Apply the string masking policy to the following columns:
```account_uid```
```depositor_id```
3. Apply the integer masking policy to the following columns:
```account_balance```
```accessible_balance```
4. Create a zero-copy clone of the ```SNOWBANK``` database. called ```SNOWBANK_DEV```
5. Create a ```BANK_DEV_WH``` for the ```BANK_DEV_ROLE``` to use.
6. Grant ```MODIFY, MONITOR, USAGE``` permissions to ```BANK_DEV_ROLE``` on ```BANK_DEV_WH```
7. Grant all database, table, schema permissions to ```BANK_DEV_ROLE``` on ```SNOWBANK_DEV```
8. Verify the differences in what masked/unmasked data the ```BANK_ENGINEER_ROLE``` and ```BANK_DEV_ROLE``` can see
9. Add a new column called ```account_type_code``` to the ```ACCOUNTS``` table in ```SNOWBANK_DEV``` where ```account_type_code=product_code```
10. Replace the old ```ACCOUNTS``` table with the **new** ```ACCOUNTS``` table
11. Delete the developer sandbox environment using a more privileged role.
12. Drop the ```ACCOUNTS``` table and use time travel to reinstate it. 

 We have now used a simple example to enforce data masking as well as giving developers a quick and easy way to make changes to the data in a non-production environment. Feel feel play around more with roles or any other data transformations you may do in your job or move on to the next part.

 Documentation: 
[https://docs.snowflake.com/en/user-guide/security-column-ddm-use](https://docs.snowflake.com/en/user-guide/security-column-ddm-use)
[https://docs.snowflake.com/en/user-guide/security-access-control-privileges](https://docs.snowflake.com/en/user-guide/security-access-control-privileges)
[https://docs.snowflake.com/en/user-guide/data-time-travel](https://docs.snowflake.com/en/user-guide/data-time-travel)

