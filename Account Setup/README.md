# Account Setup
Before we begin our journey into exploring the data we are going to setup some important resources such as roles, permissions and warehouses for you to use over the course of the hackathon.

## Create Warehouses
The first thing to set your role to **ACCOUNTADMIN** and create 2 virtual warehouses (this can be done via the UI or programtically)

1. **SNOWBANK_LOAD_WH**
2. **SNOWBANK_TASK_WH**

Ensure both warehouses are creates as Small and that the auto-suspend and auto-resume parameters are enabled. We will later grant permissions to different roles to use these warehouses in the setup script.

## Run the setup script
Run the [account setup](account_setup.sql) script to create the relevant roles and permission grants. 

Once complete you are now ready to dive into ingesting some data. 
